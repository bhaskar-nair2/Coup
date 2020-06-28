const functions = require('firebase-functions')
const admin = require('firebase-admin');

const db = admin.database(admin.app());

// Create player record when first created
exports.createUserRecord =
  functions.auth.user().onCreate(async (user, context) => {
    const userRef = db.ref("players/" + user.uid);
    return userRef.set({
      name: user.uid,
      createdAt: context.timestamp,
      nick: "PUTA",
    });
  })

exports.presenceWriter =
  functions.database.ref('/status/{uid}').onUpdate(
    async (change, context) => {
      // Get the data written to Realtime Database
      const eventStatus = change.after.val();

      // Then use other event data to create a reference to the
      // corresponding Firestore document.
      const userStatusFirestoreRef = db.ref(`status/${context.params.uid}`);

      // It is likely that the Realtime Database change that triggered
      // this event has already been overwritten by a fast change in
      // online / offline status, so we'll re-read the current data
      // and compare the timestamps.
      const statusSnapshot = await change.after.ref.once('value');
      const status = statusSnapshot.val();
      // If the current timestamp for this data is newer than
      // the data that triggered this event, we exit this function.
      if (status.last_changed > eventStatus.last_changed) {
        return null;
      }

      // Otherwise, we convert the last_changed field to a Date
      eventStatus.last_changed = new Date(status.last_changed);

      // ... and write it to Firestore.
      return userStatusFirestoreRef.update(eventStatus);
    });
