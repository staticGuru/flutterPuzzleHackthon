import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:slidingpuzzle/widgets/Move.dart';
import 'package:slidingpuzzle/widgets/Time.dart';

class dialogFromAI extends StatelessWidget {
  int secondsPassed;
  String message;
  void Function() reset;
  dialogFromAI(
    this.secondsPassed,
    this.message,
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
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "Something went Wrong!!!",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   "You have completed the puzzle!",
                    //   style: TextStyle(fontSize: 16),
                    // ),
                  ],
                ),
                Container(
                    child: Lottie.asset("assets/animations/confusedAI.json",
                        fit: BoxFit.contain)),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Time(secondsPassed, Colors.black),
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       WidgetSpan(
                      //           child: Icon(
                      //         FontAwesome.arrows_alt,
                      //         size: 18,
                      //       )),
                      //       TextSpan(
                      //         text: " ${move} moves",
                      //         style: TextStyle(
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.bold,
                      //             // decoration: TextDecoration.none,
                      //             fontSize: 18),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Text(
                        "I reconsigned below the word",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            // decoration: TextDecoration.none,
                            fontSize: 14),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            // decoration: TextDecoration.none,
                            fontSize: 20),
                      ),
                      Text(
                        "I can able to hear Numerics only!!!",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            // decoration: TextDecoration.none,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Try Again",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
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
