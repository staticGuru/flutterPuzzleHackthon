import 'package:flutter/material.dart';
import 'package:slidingpuzzle/widgets/Move.dart';

class MyTitle extends StatelessWidget {
  var size;
  int move;

  MyTitle(this.size, this.move);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: double.infinity,
      height: 150,
      child: Column(
        children: [
          Text(
            "Puzzle Hack",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.050,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          Move(move),
        ],
      ),
    );
  }
}
