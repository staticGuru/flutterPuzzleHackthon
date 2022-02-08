import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.fromLTRB(6, 40, 6, 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 7,
            crossAxisSpacing: 7,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return numbers[index] != 0
                ? GridButton("${numbers[index]}", () {
                    clickGrid(index);
                  })
                : SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
