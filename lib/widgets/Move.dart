import 'package:flutter/material.dart';

class Move extends StatelessWidget {
  int move;

  Move(this.move);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Move: ${move}",
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 18),
          ),
          Text(
            "Tiles: ${move}",
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 18),
          ),
        ],
      ),
    );
  }
}
