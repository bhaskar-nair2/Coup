import 'package:flutter/material.dart';

class BaseActCard extends StatelessWidget {
  const BaseActCard(
      {Key key, this.active, this.name, this.description, this.call})
      : super(key: key);

  final Function call;
  final bool active;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => active == true ? call() : () => {},
      child: Card(
        color: active == true ? Colors.blue : Colors.grey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 25,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Text(
                    description,
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
