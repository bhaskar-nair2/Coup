const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.database();

// player plays
// action is made
// on action make, switch to next person

// enum GameState { waiting, loading, play, counter, block, challenge }

const changeActive =  // change active
  functions.https.onCall(async (data) => {
    var playerId = data.playerId

    var table = db.ref("tables/" + data.tableId);
    var turnId = (await table.child('turn').once('value')).val()
    var turn = db.ref("turns/" + turnId)
    var playersList = (await table.child('players').orderByKey().once('value')).val()

    console.log(playersList)
    var curPlIndex = 0
    var playerKeys = []

    if (playersList !== null) {
      playerKeys = Object.keys(playersList)
      curPlIndex = playerKeys.findIndex(pl => pl === playerId)
    }

    function nextPlayer() {
      if (curPlIndex + 1 < playerKeys.length)
        return playerKeys[curPlIndex + 1]
      else
        return playerKeys[0]
    }

    console.log(curPlIndex + 1, playerKeys.length, nextPlayer())

    await turn.set({
      active: nextPlayer(),
      gameState: 'play',
      hash: 'newTurn'
    })

    return await table.update({
      "turn": turn.key
    })
  })


module.exports = {
  changeActive: changeActive
}
