const functions = require('firebase-functions')
const admin = require('firebase-admin');

var tableFunctions = require('./tableFunctions');

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

exports.presenceWriter =
  functions.firestore.document('players/{playerId}').onUpdate(async (snap, context) => {
    const before = snap.before.data();
    const after = snap.after.data();

    if (!before || !after)
      return;

    if (after.presence === false) {
      db.firestore.collection('tables').doc(after.table)
      tableFunctions.leaveTable({
        tableId: after.table,
        userId: playerId
      })
    }
  })
