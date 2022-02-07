import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {
  Function click;
  String text;
  // final player = AudioPlayer();
  GridButton(this.text, this.click);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(8.0),
      ),
      onPressed: click,
    );
  }
}
