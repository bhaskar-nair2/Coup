import 'package:flutter/material.dart';

class BaseLoadBtn extends StatelessWidget {
  const BaseLoadBtn({
    Key key,
    this.action,
    this.isLoading,
    this.text,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  final Function action;
  final bool isLoading;
  final String text;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200,
      height: height ?? 50,
      decoration: BoxDecoration(
        color: color ?? Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FlatButton(
          onPressed: this.action,
          child: this.isLoading
              ? CircularProgressIndicator(
                  strokeWidth: 1,
                )
              : Text('$text')),
    );
  }
}
