// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:slidingpuzzle/models/app_state.dart';
import 'package:slidingpuzzle/pages/levelSelection.dart';
import 'Board.dart';
import 'package:slidingpuzzle/redux/reducers.dart';

main() async {
  FlutterNativeSplash.removeAfter(initialization);

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await SystemChrome.setEnabledSystemUIOverlays([]);
  final _initialState = AppState();
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  runApp(SlidingPuzzle(store: _store));
}

void initialization(BuildContext context) async {
  // This is where you can initialize the resources needed by your app while
  // the splash screen is displayed.  Remove the following example because
  // delaying the user experience is a bad design practice!
  // ignore_for_file: avoid_print
  print('ready in 3...');
  await Future.delayed(const Duration(seconds: 1));
  print('ready in 2...');
  await Future.delayed(const Duration(seconds: 1));
  print('ready in 1...');
  await Future.delayed(const Duration(seconds: 1));
  print('go!');
}

class SlidingPuzzle extends StatelessWidget {
  final Store<AppState> store;

  SlidingPuzzle({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: "Sliding Puzzle",
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: levelSelection()),
      ),
    );
  }
}
