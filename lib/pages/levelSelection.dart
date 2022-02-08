import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class levelSelection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _levelSelectionState();
  }
}

class _levelSelectionState extends State<levelSelection> {
  final List<String> images = [
    'assets/images/4x4.png',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
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
                  Image.asset(images[0],
                      fit: BoxFit.fill, width: 1000, height: 200),
                  SizedBox(height: 10),
                  Center(
                      child: Text("Medium",
                          style: GoogleFonts.architectsDaughter(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ))),
                  SizedBox(height: 5),
                  Center(
                      child: Text("4x4",
                          style: GoogleFonts.architectsDaughter(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w500),
                          ))),
                  Container(
                    color: Colors.green[400],
                    child: TextButton(
                        onPressed: () {},
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
