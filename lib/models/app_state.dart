import 'package:flutter/material.dart';

class AppState {
  bool boardani;
  bool reset;
  bool sound;
  dynamic player;

  AppState(
      {this.boardani = true,
      this.reset = false,
      this.sound = true,
      this.player});

  AppState.fromAppState(AppState another) {
    boardani = another.boardani;
    reset = another.reset;
    sound = another.sound;
    player = another.player;
  }
}
