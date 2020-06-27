const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore();

// player plays
// action is made
// on action make, switch to next person

// enum GameState { waiting, loading, play, counter, block, challenge }

const addTurn =
  functions.https.onCall(async (data, context) => {
    var turnRef = db.collection("turns").doc(data.turnId);
    var type = data.type // action, challenge, block

    // If action type, then set action data and set `counter` state
    if (type === 'action') {
      await turnRef.update({
        action: data["action"]
      })

      if (data['action']['blockable'] === true || data['action']['blockable'] === true) {
        turnRef.update({
          status: 'counter' // this means now people are invited to block
        }) // all people will now be active
      }
      else {
        await changeActive(data)
      }
      return { status: 200, data: "Action added to Turn" }
    }
    // Incase of challenge
    else if (type === 'challenge') {
      await turnRef.update({
        challenge: data["challenge"]
      })
      turnRef.update({
        status: 'challenge'
      })
    }
    // incase of block
    else if (type === 'block') {
      await turnRef.update({
        block: data["block"]
      })
      turnRef.update({
        status: 'block'
      })
    }
    else {
      throw new functions.https.HttpsError('aborted', 'Table is Closed');
    }
  })


const changeActive =  // change active
  async (data) => {
    console.info(data)
    var playerId = data.playerId
    var tableId = data.tableId
    var turnId = data.turnId
    var jump = data.jump || 0

    var table = db.collection("tables").doc(tableId);
    var turn = db.collection("turns").doc(turnId);

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
  }



module.exports = {
  addTurn: addTurn,
  changeActive: changeActive
}
