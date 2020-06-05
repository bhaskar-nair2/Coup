const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore();

exports.createUserRecord =
  functions.auth.user().onCreate(async (user, context) => {
    const userRef = db.doc(`players/${user.uid}`);
    return userRef.set({
      name: user.uid,
      createdAt: context.timestamp,
      nick: "PUTA",
    });
  })

// only for updating details like name and all
exports.updateUserRecord =
  functions.https.onCall(async (data, context) => {
    var user = db.collection('players').doc(data.userId);
    return user.update({
      name: data.name,
      nick: data.nick
    })
  })
