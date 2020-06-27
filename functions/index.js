const functions = require('firebase-functions');
const admin = require('firebase-admin')

admin.initializeApp({
  credential: admin.credential.cert(require('./service-account-key.json'))
})

try {
  // exports.userFunctions = require('./modules/userFunctions');
  // exports.tableFunctions = require('./modules/tableFunctions');
  // exports.playerFunctions = require('./modules/playerFunctions');
  // exports.turnFunctions = require('./modules/turnFunctions');
  // exports.adminFunctions = require('./modules/adminFunctions');
}
catch (error) {
  console.log(error)
}



