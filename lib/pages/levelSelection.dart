import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slidingpuzzle/Board.dart';

class levelSelection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _levelSelectionState();
  }
}

class _levelSelectionState extends State<levelSelection> {
  final List<Map<String, String>> images = [
    {"image": 'assets/images/4x4.png', "name": "Easy", "number": "4x4"},
    {"image": 'assets/images/4x4.png', "name": "Medium", "number": "5x5"},
    {"image": 'assets/images/4x4.png', "name": "Hard", "number": "6x6"},
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
      appBar: AppBar(
        title: Text('Levels',
            style: GoogleFonts.architectsDaughter(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )),
        centerTitle: true,
        backgroundColor: Color.fromARGB(230, 218, 109, 66),
      ),
      body: Center(
        child: Container(
            child: CarouselSlider.builder(
          itemCount: images.length,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: 400,
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
          ),
          itemBuilder: (context, index, realIdx) {
            return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Color.fromARGB(230, 218, 109, 66),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Center(
                    child: ListView(children: [
                  Image.asset(images[index]["image"],
                      fit: BoxFit.fill, width: 1000, height: 200),
                  SizedBox(height: 10),
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
                    color: Colors.green[400],
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SafeArea(child: Board())));
                        },
                        child: Text("Play Now",
                            style: GoogleFonts.architectsDaughter(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ))),
                  )
                ])));
          },
        )),
      ),
    );
  }
}
