import 'package:coup/modals/game_table.dart';
import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:provider/provider.dart';

class PlayArea extends StatelessWidget {
  const PlayArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final table = Provider.of<GameTable>(context);

    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff092147),
              Color(0xff1a488e),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: ClipPolygon(
              sides: 6,
              borderRadius: 5.0, // Default 0.0 degrees
              rotate: 90.0, // Default 0.0 degrees
              child: Container(
                color: Color(0xff092147),
                padding: EdgeInsets.all(40),
                child: ClipPolygon(
                  sides: 6,
                  borderRadius: 5.0, // Default 0.0 degrees
                  rotate: 90.0, // Default 0.0 degrees
                  child: Container(
                    color: Color(0xff97b2de),
                    child: Center(
                        child: Center(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              table.occupied.toString(),
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 30),
                            ),
                          ),
                          ListView.builder(
                              itemCount: table.occupied,
                              itemBuilder: (context, index) {
                                print('xxx');
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    table.players[index].cards.toString(),
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 30),
                                  ),
                                );
                              })
                        ],
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
