import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  var size;

  MyTitle(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        "Puzzle Hack",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.height * 0.050,
            color: Colors.green,
            decoration: TextDecoration.none),
      ),
    );
  }
}
