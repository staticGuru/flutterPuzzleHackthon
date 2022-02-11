import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:slidingpuzzle/models/app_state.dart';
import 'package:slidingpuzzle/redux/actions.dart';

class ResetButton extends StatelessWidget {
  Function reset;
  String text;

  ResetButton(this.reset, this.text);
  AudioCache audioCache = AudioCache();

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  void ResetCall() {
    Future.delayed(const Duration(milliseconds: 100), () {
      reset();
    });
    audioCache.play('ResetSoundEffect.mp3', mode: PlayerMode.MEDIA_PLAYER);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: GestureDetector(
          child: Icon(
            Icons.replay,
          ),
          onTap: () {
            // StoreProvider.of<AppState>(context).dispatch(Reset(true));
            ResetCall();
            // Future.delayed(const Duration(milliseconds: 1200), () {
            //   StoreProvider.of<AppState>(context).dispatch(Reset(false));
            // });
          },
        ),
      ),
      width: 30,
      height: 30,
      decoration: new BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
    );
  }
}
