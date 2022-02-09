import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:slidingpuzzle/models/app_state.dart';
import 'package:slidingpuzzle/redux/actions.dart';

class SoundControl extends StatelessWidget {
  bool sound;

  SoundControl(this.sound);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return GestureDetector(
              child: state.sound
                  ? Icon(Ionicons.md_volume_high_outline, color: Colors.white)
                  : Icon(Ionicons.md_volume_mute_outline, color: Colors.white),
              onTap: () {
                StoreProvider.of<AppState>(context)
                    .dispatch(Sound(!state.sound));
              },
            );
          }),
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
