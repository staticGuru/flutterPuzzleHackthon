import 'package:flutter/material.dart';
import 'GridButton.dart';

class Grid extends StatelessWidget {
  var numbers = [];
  var size;
  int buttonsize;
  Function clickGrid;
  int matrix;

  Grid(this.numbers, this.size, this.clickGrid, this.buttonsize, this.matrix);

  @override
  Widget build(BuildContext context) {
    var height = size.height;

    return Container(
      height: height * 0.75,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 40, 6, 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: matrix,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return numbers[index] != 0
                ? GridButton("${numbers[index]}", () {
                    clickGrid(index);
                  }, buttonsize)
                : SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
