const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore();

// add action (player,table,data)

// * isk change (user, table, value)
exports.addTurn =
  functions.https.onCall((data, context) => {
    var user = db.collection('players').doc(data.userId);
    var turn = db.collection('turns').doc(data.tableId);

    turn.update({
      actions: db.FieldValue.arrayUnion
    })
    
  });
