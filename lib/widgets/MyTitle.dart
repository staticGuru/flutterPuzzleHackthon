import 'package:flutter/material.dart';
import 'package:slidingpuzzle/widgets/Move.dart';
import 'package:slidingpuzzle/widgets/Speech.dart';
import 'dart:io' show Platform;

class MyTitle extends StatelessWidget {
  var size;
  int move;
  int tiles;
  Function clickGrid;

  MyTitle(this.size, this.move, this.clickGrid, this.tiles);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
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
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "Statistics",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                    Move(move, tiles),
                  ],
                ),
              ),
              Platform.isAndroid
                  ? Flexible(
                      flex: 2,
                      child: Speech((e) {
                        clickGrid(e, 'AI');
                      }),
                    )
                  : SizedBox(height: 0, width: 0)
            ],
          ),
        ],
      ),
    );
  }
}
