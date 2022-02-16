import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:slidingpuzzle/models/app_state.dart';
import 'package:slidingpuzzle/redux/actions.dart';
import 'package:slidingpuzzle/widgets/ResetButton.dart';
import 'package:slidingpuzzle/widgets/Time.dart';
import 'package:slidingpuzzle/widgets/dialogFromAI.dart';
import 'package:slidingpuzzle/widgets/popupDialog.dart';
import 'package:slidingpuzzle/widgets/winningDialog.dart';
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
    {"arrayLength": 9, "matrix": 3, "buttonsize": 30},
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
    FlameAudio.bgm.initialize();
    Future.delayed(const Duration(milliseconds: 3000), () {
      StoreProvider.of<AppState>(context).dispatch(Boardani(false));
      FlameAudio.bgm.play('backgroundSound.mp3', volume: .5);
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
    FlameAudio.bgm.stop();
    // FlameAudio.bgm.clear('backgroundSound.mp3');
    // FlameAudio.bgm.clearCache();

    FlameAudio.bgm.dispose();
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
      appBar: NewGradientAppBar(
        title: Container(child: Time(secondsPassed, Colors.white)),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 0, 162, 255),
              Color.fromARGB(255, 0, 255, 145)
            ]),
        actions: [
          Center(
            child: GestureDetector(
                onTap: () {
                  FlameAudio.play('shuffle.mp3', volume: 0.8);
                  reset();
                  // FlameAudio.bgm.clear('shuffle.mp3');
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.replay,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text("Shuffle",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                )),
          )
          // IconButton(
          //   tooltip: 'Shuffle',
          // icon: Icon(
          //   Icons.replay,
          //   color: Colors.white,
          // ),
          //   onPressed: () {
          //     reset();
          //     //HomeBody().onClear();  //this has error
          //   },
          // )
        ],
      ),
      body: Container(
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 0, 162, 255),
              Color.fromARGB(255, 0, 255, 145)
            ],
          )),
          child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return state.boardani
                    ? Lottie.asset("assets/animations/ResetAnimation.json",
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          // Menu(reset, move, secondsPassed, size, sound),
                          Flexible(
                            flex: 3,
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: 400, maxHeight: 600),
                              child: Grid(
                                  numbers,
                                  size,
                                  clickGrid,
                                  gameData[widget.index]["buttonsize"],
                                  gameData[widget.index]["matrix"]),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              child: Center(
                                child: MyTitle(size, move, clickGrid,
                                    gameData[widget.index]["arrayLength"] - 1),
                              ))
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

  void clickGrid(b, mode) {
    print("777777777calledfffffffffffffff");

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => popupDialog(context),
    // );
    var index = b.runtimeType == int ? b : int.parse(b);
    print("clikddd $b $index ${b.runtimeType} $numbers");
    if (index != null && mode == 'AI') {
      index = numbers.indexOf(index) != -1 ? numbers.indexOf(index) : null;
      print('ai $index');
    }
    if (index != null) {
      print(numbers.indexOf(index));
      audioCache.play('MyCustomSoundEffect.mp3', mode: PlayerMode.LOW_LATENCY);
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
      print(numbers);

      checkWin();
    } else {
      print("dialog calledfffffffffffffff");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return dialogFromAI(1000, b, () {});
          });
    }
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
      // Future.delayed(const Duration(milliseconds: 1000), () {
      //   numbers.shuffle();
      // });
      // Future.delayed(const Duration(milliseconds: 2000), () {
      //   numbers.shuffle();
      // });
      print(numbers);
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
            return winningDialog(secondsPassed, move, reset);
          });
    }
  }
}
