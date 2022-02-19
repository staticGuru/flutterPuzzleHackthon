import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
                  ],
                ),
                Container(
                    child: Lottie.asset("assets/animations/confusedAI.json",
                        fit: BoxFit.contain)),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "I most recently recognized",
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
