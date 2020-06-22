const functions = require('firebase-functions')
const admin = require('firebase-admin');
const { user } = require('firebase-functions/lib/providers/auth');
const { firestore } = require('firebase-admin');

const db = admin.firestore();

const MIN_PLAYERS = 2;

exports.joinTable =
  functions.https.onCall(async (data, context) => {
    var pin = "up" + Math.random() * 100

    function tableHasPLayer(id, arr) {
      if (arr.includes(id))
        return true
      else
        return false
    }

    if (data.tableId !== null && data.userId !== null) {
      var table = db.collection("tables").doc(data.tableId);
      var user = db.collection("players").doc(data.userId);
      var upData = { updatePin: pin }

      var tableData = (await table.get()).data()
      var playerList = tableData.players.map(p => p)

      // table is open
      // round is not in progress
      if (
        tableData.isOpen === true ||
        tableData.inProgress === false ||
        tableHasPLayer(data.userId, playerList)
      ) {
        // no duplicate player
        var newOccupied = tableData.players.length + 1
        upData.table = table
        upData.occupied = newOccupied
        upData.players = admin.firestore.FieldValue.arrayUnion(user)

        await user.update({
          table: table
        })

        await table.update(upData)

        if (newOccupied === 1) {
          // update active in turn
          tableData.turn.set({
            active: user
          }, { merge: true });
        }

      }
      else {
        throw new functions.https.HttpsError('aborted', 'Table is Closed');
      }
      return { status: 200, data: "Added to table" }
    }
    else
      throw new functions.https.HttpsError('invalid-argument', 'Error in data');
  })

// todo: Correct this
exports.leaveTable =
  functions.https.onCall(async (data, context) => {
    if (data.tableId !== null && data.userId !== null) {
      var table = db.collection("tables").doc(data.tableId);
      var user = db.collection("players").doc(data.userId);
      var tableData = (await table.get()).data()

      // var player = tableData.players.find(pl => pl === user)

      // if (player === undefined) {
      //   return { status: 200, data: "Not in table" }
      // }

      var newOccupied = tableData.players.length - 1

      table.update({
        occupied: newOccupied,
        isOpen: newOccupied < 6 ? true : false,
        players: admin.firestore.FieldValue.arrayRemove(user)
      })

      user.update({
        isk: null,
        hand: null,
        chance: false,
        table: null
      })

      return { status: 200, data: "Removed from table" }
    }
    else
      throw new functions.https.HttpsError('invalid-argument', 'Error in data');
  })

exports.correctSetup =
  functions.firestore.document('tables/{tableId}').onUpdate(async (snap, context) => {
    const before = snap.before.data();
    const after = snap.after.data();
    var tbRef = snap.after.ref
    var tnRef = after.turn
    var pin = "up" + Math.random() * 100

    var upData = {
      updatePin: pin
    }

    if (!before || !after)
      return;

    if (after.players.length === 0)
      tbRef.delete()

    // else if (before.updatePin === after.updatePin)
    //   return

    if (after.occupied !== after.players.length) {
      if (after.occupied <= 1) {
        upData.active = after.players[0]
        tnRef.set({
          active: after.players[0]
        })
      }
      if (after.occupied <= MIN_PLAYERS) {
        upData.state = 'waiting'
        upData.inProgress = false
      }
      upData.occupied = after.players.length
      upData.isOpen = after.players.length < 6 ? true : false
      tbRef.update(upData)
      return
    }

    return
  })

exports.startGame =
  functions.https.onCall(async (data, context) => {
    const table = db.collection('tables').doc(data.tableId)
    const tableData = (await table.get()).data()
    const playerList = tableData.players.map(p => p)
    const playerCount = playerList.length
    const cards = dealCards(playerCount)

    playerList.forEach((player, index) => {
      player.update({
        isk: 0,
        hand: cards[index],
      })
    })

    table.update({ state: 'play', inProgress: true })

    return { status: 200, data: "Game Started" }
  })



function dealCards(playerCount) {
  // will return [[],[],[],[]]
  var count = 3
  const cards = [
    { name: 'contessa', count: count },
    { name: 'duke', count: count },
    { name: 'assassin', count: count },
    { name: 'ambassador', count: count },
    { name: 'captain', count: count }
  ]
  var deal = [];
  var res = [];

  while (playerCount--) {
    for (var n = 0; n < 2; n++) {
      var x = Math.floor(Math.random() * cards.length);
      res.push(cards[x].name)
      cards[x].count -= 1
      if (cards[x].count === 0) cards.splice(x, 1);
    }
    deal.push(res)
    res = []
  }
  return deal;
}

exports.removeOffline =
  functions.firestore.document('status/{uid}').onUpdate(async (snap, context) => {
    const userRef = db.collection('players').doc(context.params.uid)
    const after = snap.after.data()
    const status = after['status'] === 'online'
    const userData = (await userRef.get()).data()

    if (status === false) {
      if (userData['table'] !== null) {
        var tableRef = userData['table']
        tableRef.update({
          players: admin.firestore.FieldValue.arrayRemove(userRef)
        })
        userRef.update({
          table: admin.firestore.FieldValue.delete()
        })
      }
    }

  })
