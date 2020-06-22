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
functions.database.ref('/status/{uid}').onUpdate(
  async (change, context) => {
    // Get the data written to Realtime Database
    const eventStatus = change.after.val();

    // Then use other event data to create a reference to the
    // corresponding Firestore document.
    const userStatusFirestoreRef = db.doc(`status/${context.params.uid}`);

    // It is likely that the Realtime Database change that triggered
    // this event has already been overwritten by a fast change in
    // online / offline status, so we'll re-read the current data
    // and compare the timestamps.
    const statusSnapshot = await change.after.ref.once('value');
    const status = statusSnapshot.val();
    console.log(status, eventStatus);
    // If the current timestamp for this data is newer than
    // the data that triggered this event, we exit this function.
    if (status.last_changed > eventStatus.last_changed) {
      return null;
    }

    // Otherwise, we convert the last_changed field to a Date
    eventStatus.last_changed = new Date(eventStatus.last_changed);

    // ... and write it to Firestore.
    return userStatusFirestoreRef.set(eventStatus);
  });
