import 'package:flutter/material.dart';

class Move extends StatelessWidget {
  int move;

  Move(this.move);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Move: ${move}",
          style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: 18),
        ),
      ),
      width: 100,
      height: 30,
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      decoration: new BoxDecoration(
          color: Colors.green,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
