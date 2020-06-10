const functions = require('firebase-functions');
const admin = require('firebase-admin')

admin.initializeApp({
  credential: admin.credential.cert(require('./service-account-key.json'))
})

exports.userFunctions = require('./modules/userFunctions');
exports.tableFunctions = require('./modules/tableFunctions');
exports.playerFunctions = require('./modules/playerFunctions');
exports.turnFunctions = require('./modules/turnFunctions');
// exports.globalActionFunctions = require('./modules/globalActionFunctions')

