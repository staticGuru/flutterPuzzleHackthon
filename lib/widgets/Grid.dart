import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lottie/lottie.dart';
import 'package:slidingpuzzle/models/app_state.dart';
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
      child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 20, 6, 20),
          child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: matrix,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: numbers.length,
                  itemBuilder: (context, index) {
                    return numbers[index] != 0
                        ? GridButton("${numbers[index]}", () {
                            clickGrid(index, 'MANUVAL');
                          }, buttonsize)
                        : SizedBox.shrink();
                  },
                );
              })),
    );
  }
}
