import 'package:flutter/material.dart';

class Move extends StatelessWidget {
  int move;
  int tiles;

  Move(this.move, this.tiles);

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
            "Tiles: ${tiles}",
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
