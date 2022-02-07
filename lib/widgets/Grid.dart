import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'GridButton.dart';

class Grid extends StatelessWidget {
  var numbers = [];
  var size;
  Function clickGrid;

  Grid(this.numbers, this.size, this.clickGrid);

  @override
  Widget build(BuildContext context) {
    var height = size.height;

    return Container(
      height: height * 0.75,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 50, 6, 20),
        child: Lottie.asset('assets/animations/ResetAnimation.json'),
      ),
    );
  }
}
