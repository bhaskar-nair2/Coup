import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class PlayArea extends StatelessWidget {
  const PlayArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(bottom: 50),
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
