import 'package:flutter/material.dart';
import 'package:slidingpuzzle/widgets/SoundControl.dart';
import 'Time.dart';
import 'ResetButton.dart';
import 'Move.dart';

class Menu extends StatelessWidget {
  Function reset;
  int move;
  int secondsPassed;
  var size;
  bool sound;

  Menu(this.reset, this.move, this.secondsPassed, this.size, this.sound);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.10,
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ResetButton(reset, "Reset"),
            Time(secondsPassed),
            // Move(move),
            SoundControl(sound)
          ],
        ),
      ),
    );
  }
}
