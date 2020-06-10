const functions = require('firebase-functions')
const admin = require('firebase-admin')

const db = admin.firestore();

// player plays
// action is made
// on action make, switch to next person

const addTurn =
  functions.https.onCall(async (data, context) => {
    var turn = db.collection("turns").doc(data.turnId);

    console.log(data)

    await turn.update({
      action: data["action"]
    })

    await changeActive(data)

    return { status: 200, data: "Action added to Turn" }
  })


const changeActive =  // change active
  async (data) => {
    var playerId = data.playerId
    var tableId = data.tableId
    var jump = data.jump || 0

    var table = db.collection("tables").doc(tableId);

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

    console.log(curPlIndex)
    console.log(nextPlayer())


    return await table.update({
      active: nextPlayer()
    })
  }

module.exports = {
  addTurn: addTurn,
  changeActive: changeActive
}
