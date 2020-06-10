import 'package:flutter/material.dart';

class AvailableActions extends StatelessWidget {
  const AvailableActions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            color: Colors.grey.shade100,
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10,
          );
        },
      ),
    );
  }
}

// Wrap(
//         spacing: 20,
//         alignment: WrapAlignment.start,
//         children: <Widget>[
//           Container(
//             height: 60,
//             width: 100,
//             color: Colors.grey,
//           ),
//           Container(
//             height: 60,
//             width: 100,
//             color: Colors.grey,
//           ),
//           Container(
//             height: 60,
//             width: 100,
//             color: Colors.grey,
//           )
//         ],
//       )
