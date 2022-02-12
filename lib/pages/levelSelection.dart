import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:slidingpuzzle/Board.dart';

class levelSelection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _levelSelectionState();
  }
}

class _levelSelectionState extends State<levelSelection> {
  final List<dynamic> images = [
    {"image": 'assets/images/4x4.png', "name": "Easy", "number": "4x4"},
    {"image": 'assets/images/5x5.png', "name": "Medium", "number": "5x5"},
    {"image": 'assets/images/6x6.png', "name": "Hard", "number": "6x6"},
  ];

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   images.forEach((imageUrl) {
    //     precacheImage(NetworkImage(imageUrl), context);
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(239, 255, 255, 255),
      appBar: NewGradientAppBar(
        title: Text('Levels',
            style: GoogleFonts.architectsDaughter(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )),
        centerTitle: true,
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 0, 162, 255),
              Color.fromARGB(255, 38, 221, 21),
              Color.fromARGB(255, 0, 255, 145)
            ]),
      ),
      body: Stack(
        children: [
          Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                //   colors: [
                //     Color.fromARGB(255, 251, 223, 64),
                //     Color.fromARGB(235, 54, 177, 239),
                //   ],
                // ),
                image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover),
              )),
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(83, 251, 223, 64),
                  Color.fromARGB(235, 54, 177, 239),
                ],
              ),
              // image: DecorationImage(
              //     image: AssetImage("assets/images/background.jpg"),
              //     fit: BoxFit.cover),
            ),
            child: Center(
              child: CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  height: 400,
                  aspectRatio: 24 / 8,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                itemBuilder: (context, index, realIdx) {
                  return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        // color: Color.fromARGB(230, 218, 109, 66),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 251, 176, 64),
                            Color.fromARGB(255, 239, 66, 54),
                          ],
                        ),
                      ),
                      child: Center(
                          child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Column(children: [
                          // Image.asset(images[index]["image"],
                          //     fit: BoxFit.fill,
                          //     height: 200,
                          //     width: double.infinity),
                          Center(
                              child: Text(images[index]["name"],
                                  style: GoogleFonts.architectsDaughter(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          SizedBox(height: 5),
                          Center(
                              child: Text(images[index]["number"],
                                  style: GoogleFonts.architectsDaughter(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w500),
                                  ))),
                          Container(
                            color: Colors.transparent,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SafeArea(child: Board(index))));
                              },
                              child: GradientText(
                                'START',
                                style: GoogleFonts.architectsDaughter(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                colors: [
                                  Color.fromARGB(255, 91, 9, 214),
                                  Colors.teal,
                                ],
                              ),
                              // child: Text(
                              //   "Play Now",
                              //   style: GoogleFonts.architectsDaughter(
                              //     textStyle: TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 40,
                              //         fontWeight: FontWeight.bold),
                              //   ),
                              // ),
                            ),
                          )
                        ]),
                      )));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
