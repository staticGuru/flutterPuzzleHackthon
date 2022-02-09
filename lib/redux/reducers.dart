import 'package:slidingpuzzle/models/app_state.dart';
import 'package:slidingpuzzle/redux/actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is Boardani) {
    newState.boardani = action.payload;
  } else if (action is Reset) {
    newState.reset = action.payload;
  } else if (action is Sound) {
    newState.sound = action.payload;
  } else if (action is Player) {
    newState.player = action.payload;
  }

  return newState;
}
