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

    var table = db.collection("tables").doc(data.tableId);
    var turn = db.collection("turns").doc(data.turnId);

    var tableData = (await table.get()).data()

    var playersList = tableData.players

    if (playersList.length > 0) {
      var curPlIndex =
        playersList.findIndex(pl => pl.id === playerId) // from db
    }

    function nextPlayer() {
      if (curPlIndex + 1 + jump < playersList.length)
        return playersList[curPlIndex + 1 + jump]
      else
        return playersList[0 + jump]
    }

    return await turn.update({
      active: db.collection("players").doc(nextPlayer())
    })
  })


module.exports = {
  addTurn: addTurn,
  changeActive: changeActive
}
