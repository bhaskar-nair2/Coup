import 'dart:math';
import 'dart:ui';

import 'package:coup/modals/firebase/turn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerHolder extends StatefulWidget {
  TimerHolder({Key key}) : super(key: key);

  @override
  _TimerHolderState createState() => _TimerHolderState();
}

class _TimerHolderState extends State<TimerHolder>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var turn = Provider.of<Turn>(context);
    var active = turn?.chance?.active ?? false;

    if (active == true) {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    } else {
      controller.reset();
      controller.stop();
    }

    return Align(
      alignment: FractionalOffset.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Stack(children: [
          AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              return CustomPaint(
                size: Size(40, 40),
                painter: CustomTimerPainter(
                  animation: controller,
                  backgroundColor: Colors.grey.shade500,
                  color: Colors.red,
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final AnimationController animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);

    Duration duration = animation.duration * animation.value;
    var timerString = (duration.inSeconds).toString().padLeft(2, '0');

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
    );
    final textSpan = TextSpan(
      text: '$timerString',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    textPainter.paint(
        canvas,
        Offset(
          (size.width - textPainter.width) * 0.5,
          (size.height - textPainter.height) * 0.5,
        ));
  }

  @override
  bool shouldRepaint(covariant CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
