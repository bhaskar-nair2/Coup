const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore();

exports.updateHand =
  functions.https.onCall(async (data, context) => {
    var table = db.collection('tables').doc(data.tableId) // use to make sure user is on table
    var user = db.collection('players').doc(data.userId);

    return user.update({
      hand: data.hand,
    })
  })

exports.updateIsk =
  functions.https.onCall(async (data, context) => {
    var table = db.collection('tables').doc(data.tableId) // use to make sure user is on table
    var user = db.collection('players').doc(data.userId);

    return user.update({
      isk: data.isk
    })
  })

// exports.updateChance
