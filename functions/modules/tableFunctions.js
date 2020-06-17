const functions = require('firebase-functions')
const admin = require('firebase-admin');
const { user } = require('firebase-functions/lib/providers/auth');

const db = admin.firestore();

exports.joinTable =
  functions.https.onCall(async (data, context) => {
    if (data.tableId !== null && data.userId !== null) {
      var table = db.collection("tables").doc(data.tableId);
      var user = db.collection("players").doc(data.userId);

      var tableData = (await table.get()).data()

      // table is open
      // round is not in progress
      if (tableData.isOpen === true && tableData.inProgress === false) {
        // no duplicate player
        var newOccupied = tableData.players.length + 1

        await user.update({
          table: table
        })

        await table.update({
          occupied: newOccupied,
          isOpen: newOccupied < 6 ? true : false,
          players: admin.firestore.FieldValue.arrayUnion(user)
        })

        if (newOccupied === 1) {
          // update active in turn
          tableData.turn.set({
            active: user
          }, { merge: true });
        }

      }
      else {
        throw new functions.https.HttpsError('aborted', 'Table already full');
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

    var upData = {}

    // * Do not Delete table on empty as it will cost extra

    if (!before || !after)
      return;

    var tbRef = snap.after.ref
    var tnRef = after.turn

    if (after.occupied !== after.players.length) {
      upData = {
        occupied: after.players.length,
        isOpen: after.players.length < 6 ? true : false
      }
      tbRef.update(upData)
      return
    }

    if (after.occupied === 1) {
      tbRef.update({status:'waiting', inProgress:false})
      upData.active = after.players[0]
      tnRef.update(upData)
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
  console.log(cards)
  return deal;
}




// exports.continueGame =
//   functions.https.onCall((data, context) => {
//     if (data.tableId !== null && data.userId !== null) {
//       db.runTransaction(async () => {
//         var table = db.collection("tables").doc(data.tableId);
//         var user = db.collection("players").doc(data.userId);

//         var tableData = (await table.get()).data()

//         // table is open
//         if (tableData.isOpen === true) {
//           // no duplicate player
//           var newOccupied = tableData.players.length + 1
//           user.update({
//             isk: 0,
//             hand: dealCards(),
//             chance: false,
//             table: table
//           })
//           return table.update({
//             occupied: newOccupied,
//             isOpen: newOccupied < 6 ? true : false,
//             players: admin.firestore.FieldValue.arrayUnion(user)
//           })
//         }
//         else {
//           throw new functions.https.HttpsError('aborted', 'Table already full');
//         }
//       }).then(() => {
//         return { status: 200, data: "Added to table" }
//       }).catch(error => {
//         throw new functions.https.HttpsError('invalid-argument', 'Some error occoured');
//       })
//     }
//     else
//       throw new functions.https.HttpsError('invalid-argument', 'Error in data');
//   })
