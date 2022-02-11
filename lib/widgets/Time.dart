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
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            child: Icon(Icons.timer),
            padding: EdgeInsets.only(right: 5),
          ),
          Text(
            "${_printDuration(Duration(seconds: this.secondsPassed))}",
            style: TextStyle(
              fontSize: 18,
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
