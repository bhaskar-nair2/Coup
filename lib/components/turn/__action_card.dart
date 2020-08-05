import 'package:coup/components/actionDialogs/coup_dialog.dart';
import 'package:coup/modals/game/actions.dart';
import 'package:coup/repos/firebase/commons.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard(this.action, {Key key, this.legal = false})
      : super(key: key);

  final bool legal;

  final CardAction action;

  @override
  Widget build(BuildContext context) {
    doAction() async {
      String effected;

      if (action.effectsPlayer == true) {
        effected =
            await showDialog(context: context, child: CoupDialog(context));
        if (effected == null) return;
      }
      FirebaseCommons.addTurn(context, action, effected: effected);
    }

    // used to rebuild widget for update
    // if (action.activator != null) {
    action.active = true; //action.activator(context);
    // }

    return GestureDetector(
      onTap: () => action.active == true ? doAction() : () => {},
      child: Card(
        shadowColor: legal ? Colors.green : Colors.red,
        elevation: 5,
        color: action.active == true ? Colors.blue : Colors.grey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 25,
                  child: Text(
                    action.name,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Text(
                    action.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class ChallengeCard extends StatelessWidget {
//   const ChallengeCard({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FirebaseCommons.addTurn(context),
//       child: Card(
//         shadowColor: Colors.greenAccent,
//         elevation: 5,
//         color: Colors.redAccent,
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 SizedBox(
//                   height: 25,
//                   child: Text(
//                     "Challenge",
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 25,
//                   child: Text(
//                     "Challenge Player's last Action",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 8),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
