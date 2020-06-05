const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore();

// add action (player,table,data)

// * isk change (user, table, value)
exports.iskChange =
  functions.https.onCall(async (data, context) => {
    var table = db.collection("tables").doc(data.tableId);
    var user = db.collection("players").doc(data.userId);
    var tableData = (await table.get()).data()

    var player = tableData.players.find(pl => pl.id === data.userId)

  })
