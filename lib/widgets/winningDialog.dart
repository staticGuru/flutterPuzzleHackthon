import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:slidingpuzzle/widgets/Time.dart';

class winningDialog extends StatelessWidget {
  int secondsPassed;
  int move;
  void Function() reset;
  winningDialog(
    this.secondsPassed,
    this.move,
    this.reset, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: FractionallySizedBox(
        heightFactor: 0.7,
        widthFactor: (defaultTargetPlatform == TargetPlatform.linux ||
                defaultTargetPlatform == TargetPlatform.macOS ||
                defaultTargetPlatform == TargetPlatform.windows)
            ? 0.5
            : 1,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Center(
                      child: Text(
                        "GREAT JOB!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "You have completed the puzzle!",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 200, maxHeight: 400),
                      child: Lottie.asset("assets/animations/winner.json",
                          fit: BoxFit.contain)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(child: Time(secondsPassed, Colors.black), flex: 1),
                    Flexible(
                      flex: 1,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                                child: Icon(
                              FontAwesome.arrows_alt,
                              size: 18,
                            )),
                            TextSpan(
                              text: " ${move} moves",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  // decoration: TextDecoration.none,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          reset();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Try Again",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 18),
                        ),
                      ),
                    ),
                    RaisedButton(
                      elevation: 60,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Level Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: Color.fromARGB(255, 29, 177, 76),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
