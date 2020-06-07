const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore();

exports.joinTable =
  functions.https.onCall(async (data, context) => {
    if (data.tableId !== null && data.userId !== null) {
      var table = db.collection("tables").doc(data.tableId);
      var user = db.collection("players").doc(data.userId);
      var tableData = (await table.get()).data()

      // table is open
      if (tableData.isOpen === true) {
        // no duplicate player
        var newOccupied = tableData.players.length + 1

        table.update({
          occupied: newOccupied,
          isOpen: newOccupied < 6 ? true : false,
          players: admin.firestore.FieldValue.arrayUnion(user)
        })

        user.update({
          isk: 0,
          hand: dealCards(),
          chance: false,
          table: table
        })

        return { status: 200, data: "Added to table" }
      }
      else {
        throw new functions.https.HttpsError('aborted', 'Table already full');
      }
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
        players: db.FieldValue.arrayRemove(user)
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

exports.correctOccupied =
  functions.firestore.document('tables/{tableId}').onUpdate(async (snap, context) => {
    const before = snap.before.data();
    const after = snap.after.data();

    // * Do not Delete table on empty as it will cost extra

    if (!before || !after)
      return;

    var ref = snap.after.ref
    if (after.occupied !== after.players.length) {
      ref.update(
        {
          occupied: after.players.length,
          isOpen: after.players.length < 6 ? true : false
        })
      return
    }
    return
  })

exports.setChance =
  functions.https.onCall(async (data, context) => {
    // update table chance to next user
  })

function dealCards() {
  // TODO: need a way to deal only 4 of each type in a table
  const cards = ['contessa', 'duke', 'assassin', 'ambassador', 'captain']
  var deal = getRandom(cards, 2);
  return deal;
}

function getRandom(arr, n) {
  var result = new Array(n),
    len = arr.length,
    taken = new Array(len);
  if (n > len)
    throw new RangeError("getRandom: more elements taken than available");
  while (n--) {
    var x = Math.floor(Math.random() * len);
    result[n] = arr[x in taken ? taken[x] : x];
    taken[x] = --len in taken ? taken[len] : len;
  }
  return result;
}
