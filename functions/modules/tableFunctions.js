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
      // round is not in progress
      if (tableData.isOpen === true && tableData.inProgress === false) {
        // no duplicate player
        var newOccupied = tableData.players.length + 1

        await user.update({
          isk: 0,
          hand: dealCards(),
          chance: false,
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
      upData.active = after.players[0]
      tnRef.update(upData)
      return
    }
    else {
      console.log('Occupied: ', after.occupied)
    }

    return
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
