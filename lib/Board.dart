import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lottie/lottie.dart';
import 'package:slidingpuzzle/models/app_state.dart';
import 'package:slidingpuzzle/redux/actions.dart';
import 'widgets/Menu.dart';
import 'widgets/MyTitle.dart';
import 'widgets/Grid.dart';

class Board extends StatefulWidget {
  int index = 0;
  Board(this.index);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> with WidgetsBindingObserver {
  static final List<dynamic> gameData = [
    {"arrayLength": 16, "matrix": 4, "buttonsize": 30},
    {"arrayLength": 25, "matrix": 5, "buttonsize": 20},
    {"arrayLength": 36, "matrix": 6, "buttonsize": 15}
  ];
  int index = 0;
  var numbers = [];
  int move = 0;
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer timer;
  bool sound = false;
  // AudioCache audioCache = AudioCache();
  var instance;
  AudioPlayer player = new AudioPlayer();
  AudioCache audioCache;
  // AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  @override
  void initState() {
    super.initState();
    numbers =
        Iterable<int>.generate(gameData[widget.index]["arrayLength"]).toList();

    numbers.shuffle();

    audioCache = new AudioCache(fixedPlayer: player);
    Future.delayed(const Duration(milliseconds: 3000), () {
      StoreProvider.of<AppState>(context).dispatch(Boardani(false));
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("Current state = $state");
  }

  @override
  void deactivate() {
    StoreProvider.of<AppState>(context).dispatch(Boardani(true));
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.index);

    final size = MediaQuery.of(context).size;
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        startTime();
      });
    }

    return Scaffold(
      body: Container(
          height: size.height,
          color: Colors.transparent,
          child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return state.boardani
                    ? Lottie.asset("assets/animations/ResetAnimation.json",
                        fit: BoxFit.contain)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Menu(reset, move, secondsPassed, size, sound),
                          Grid(
                              numbers,
                              size,
                              clickGrid,
                              gameData[widget.index]["buttonsize"],
                              gameData[widget.index]["matrix"]),
                          MyTitle(size, move),
                        ],
                      );
              })),
    );
  }

  @override
  void dispose() {
    player.stop();

    print("dispose called");
    super.dispose();
  }

  void clickGrid(index) {
    audioCache.play('MyCustomSoundEffect.mp3', mode: PlayerMode.MEDIA_PLAYER);
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 &&
            numbers[index - 1] == 0 &&
            index % gameData[widget.index]["matrix"] != 0 ||
        index + 1 <
                (gameData[widget.index]["matrix"] *
                    gameData[widget.index]["matrix"]) &&
            numbers[index + 1] == 0 &&
            (index + 1) % gameData[widget.index]["matrix"] != 0 ||
        (index - gameData[widget.index]["matrix"] >= 0 &&
            numbers[index - gameData[widget.index]["matrix"]] == 0) ||
        (index + gameData[widget.index]["matrix"] <
                (gameData[widget.index]["matrix"] *
                    gameData[widget.index]["matrix"]) &&
            numbers[index + gameData[widget.index]["matrix"]] == 0)) {
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
      Future.delayed(const Duration(milliseconds: 1000), () {
        numbers.shuffle();
      });
      Future.delayed(const Duration(milliseconds: 2000), () {
        numbers.shuffle();
      });

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
