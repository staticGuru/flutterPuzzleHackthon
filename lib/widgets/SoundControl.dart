import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SoundControl extends StatelessWidget {
  int move;

  SoundControl(this.move);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(MaterialCommunityIcons.star),
      width: 100,
      height: 30,
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      decoration: new BoxDecoration(
          color: Colors.green,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
