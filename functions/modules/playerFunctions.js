const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore();

exports.updateHand =
  functions.https.onCall(async (data, context) => {
    var user = db.collection('players').doc(data.userId);

    return user.set({
      name: data.name,
      nick: data.nick
    })
  })

// exports.updateIsk
// exports.updateChance
