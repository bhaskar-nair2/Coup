const functions = require('firebase-functions')
const admin = require('firebase-admin');

const db = admin.database(admin.app());

// Create player record when first created
const createUserRecord =
  functions.auth.user().onCreate(async (user, context) => {
    const userRef = db.ref("players/" + user.uid);
    return userRef.set({
      name: user.uid,
      createdAt: context.timestamp,
      nick: "PUTA",
    });
  })

const presenceWriter =
  functions.database.ref('/status/{uid}').onUpdate(
    async (change, context) => {
      // Get the data written to Realtime Database
      const eventStatus = change.after.val();

      // Then use other event data to create a reference to the
      // corresponding Firestore document.
      const userDBRef = db.ref(`players/${context.params.uid}`);
      const statRef = db.ref(`status/${context.params.uid}`)

      // It is likely that the Realtime Database change that triggered
      // this event has already been overwritten by a fast change in
      // online / offline status, so we'll re-read the current data
      // and compare the timestamps.
      const statusSnapshot = (await change.after.ref.once('value')).val();
      const status = statusSnapshot['state'] === 'online'

      // If the current timestamp for this data is newer than
      // the data that triggered this event, we exit this function.
      if (status.last_changed > eventStatus.last_changed) {
        return null;
      }
      else if (status === false) {  // Remove offline user from any table
        var userData = (await userDBRef.once('value')).val()
        if (userData['table'] !== null) {
          var tableRef = db.ref(`tables/${userData['table']}`);
          tableRef.child('players/' + context.params.uid).remove()
        }
        userDBRef.child('table').remove()
      }
      // Otherwise, we convert the last_changed field to a Date
      eventStatus.last_changed = new Date(status.last_changed);
      return statRef.update(eventStatus);
    });

module.exports = {
  createUserRecord,
  presenceWriter
}
