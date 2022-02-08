import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class levelSelection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _levelSelectionState();
  }
}

class _levelSelectionState extends State<levelSelection> {
  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
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
      appBar: AppBar(
        title: Text('Levels'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
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
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                child: Center(
                    child: Column(children: [
                  Image.network(images[index], fit: BoxFit.cover, width: 1000),
                  Center(child: Text("Easy")),
                  Center(child: Text("4 X 4")),
                  Center(child: Text("Matrix"))
                ])));
          },
        )),
      ),
    );
  }
}
