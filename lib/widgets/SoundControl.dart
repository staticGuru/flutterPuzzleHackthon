import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SoundControl extends StatelessWidget {
  bool sound;

  SoundControl(this.sound);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Ionicons.md_volume_high_outline, color: Colors.white),
      width: 20,
      height: 30,
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      decoration: new BoxDecoration(
          color: Colors.green,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
