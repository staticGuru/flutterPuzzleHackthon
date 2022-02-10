import 'package:flutter/material.dart';
import 'package:slidingpuzzle/widgets/Move.dart';
import 'package:slidingpuzzle/widgets/Speech.dart';

class MyTitle extends StatelessWidget {
  var size;
  int move;
  Function clickGrid;

  MyTitle(this.size, this.move, this.clickGrid);

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
          Speech((e) {
            print("eee $e");
            clickGrid(e);
          })
        ],
      ),
    );
  }
}
