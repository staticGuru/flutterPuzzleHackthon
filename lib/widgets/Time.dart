import 'package:flutter/material.dart';

class Time extends StatelessWidget {
  int secondsPassed;

  Time(this.secondsPassed);
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        "Time: ${_printDuration(Duration(seconds: this.secondsPassed))}",
        style: TextStyle(
          fontSize: 18,
          decoration: TextDecoration.none,
          color: Colors.white,
        ),
      ),
    );
  }
}
