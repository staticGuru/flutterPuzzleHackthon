import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  Function reset;
  String text;

  ResetButton(this.reset, this.text);
  AudioCache audioCache = AudioCache();

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  void ResetCall() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      reset();
    });
    audioCache.play('ResetSoundEffect.mp3', mode: PlayerMode.MEDIA_PLAYER);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Icon(
          Icons.replay,
        ),
        onTap: () {
          ResetCall();
        },
      ),
      width: 30,
      height: 30,
      decoration: new BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
    );
  }
}
