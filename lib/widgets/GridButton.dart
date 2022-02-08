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
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      color: Color.fromARGB(220, 132, 36, 12),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      onPressed: click,
    );
  }
}
