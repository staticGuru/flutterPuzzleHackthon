import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'widgets/Menu.dart';
import 'widgets/MyTitle.dart';
import 'widgets/Grid.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  var numbers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35
  ];
  int move = 0;
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer timer;
  bool sound = false;
  AudioCache audioCache = AudioCache();

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  @override
  void initState() {
    super.initState();
    numbers.shuffle();
    // audioCache.loop('backgroundSoundEffect.mp3', mode: PlayerMode.MEDIA_PLAYER);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        startTime();
      });
    }

    return SafeArea(
      child: Container(
        height: size.height,
        color: Color.fromARGB(230, 218, 109, 66),
        child: Column(
          children: <Widget>[
            Menu(reset, move, secondsPassed, size, sound),
            Grid(numbers, size, clickGrid),
            MyTitle(size, move),
          ],
        ),
      ),
    );
  }

  // Future<AudioPlayer> playLocalAsset() async {
  //   AudioCache cache = new AudioCache();
  //   return await cache.play("myCustomSoundEffect.mp3");
  // }

  // void clickGrid(index) {
  //   audioCache.play('MyCustomSoundEffect.mp3', mode: PlayerMode.MEDIA_PLAYER);
  //   if (secondsPassed == 0) {
  //     isActive = true;
  //   }
  //   if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
  //       index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
  //       (index - 4 >= 0 && numbers[index - 4] == 0) ||
  //       (index + 4 < 16 && numbers[index + 4] == 0)) {
  //     setState(() {
  //       move++;
  //       numbers[numbers.indexOf(0)] = numbers[index];
  //       numbers[index] = 0;
  //     });
  //   }
  //   checkWin();
  // }
  // void clickGrid(index) {
  //   audioCache.play('MyCustomSoundEffect.mp3', mode: PlayerMode.MEDIA_PLAYER);
  //   if (secondsPassed == 0) {
  //     isActive = true;
  //   }
  //   if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 5 != 0 ||
  //       index + 1 < 25 && numbers[index + 1] == 0 && (index + 1) % 5 != 0 ||
  //       (index - 5 >= 0 && numbers[index - 5] == 0) ||
  //       (index + 5 < 25 && numbers[index + 5] == 0)) {
  //     setState(() {
  //       move++;
  //       numbers[numbers.indexOf(0)] = numbers[index];
  //       numbers[index] = 0;
  //     });
  //   }
  //   checkWin();
  // }
  void clickGrid(index) {
    audioCache.play('MyCustomSoundEffect.mp3', mode: PlayerMode.MEDIA_PLAYER);
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 6 != 0 ||
        index + 1 < 36 && numbers[index + 1] == 0 && (index + 1) % 6 != 0 ||
        (index - 6 >= 0 && numbers[index - 6] == 0) ||
        (index + 6 < 36 && numbers[index + 6] == 0)) {
      setState(() {
        move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    checkWin();
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void reset() {
    setState(() {
      numbers.shuffle();
      move = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You Win!!",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 220.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
