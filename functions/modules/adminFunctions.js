// DO NOT DEPLOY
const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore();

exports.delAllUsers =
  functions.https.onCall(async (data, context) => {
    admin.auth().listUsers()
      .then((listUsersResult) => {
        listUsersResult.users.forEach((userRecord) => {
          console.log('user', userRecord.uid);
          admin.auth().deleteUser(userRecord.uid)
        });
        if (listUsersResult.pageToken) {
          // List next batch of users.
          listAllUsers(listUsersResult.pageToken);
        }
        return;
      })
      .catch((error) => {
        console.log('Error listing users:', error);
      });
    return;
  });
