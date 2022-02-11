import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {
  Function click;
  String text;
  int buttonsize;
  // final player = AudioPlayer();
  GridButton(this.text, this.click, this.buttonsize);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 251, 176, 64),
            Color.fromARGB(255, 239, 66, 54),
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: RaisedButton(
        child: Text(
          text,
          style: TextStyle(
            fontSize: buttonsize.toDouble(),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        onPressed: click,
      ),
    );
  }
}
