import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_bank_auth/util/cardSlider.dart';
import 'package:food_bank_auth/services/dataprocess.dart';

class foodFocusPage extends StatefulWidget {
  @override
  _foodFocusPageState createState() => _foodFocusPageState();
}

class _foodFocusPageState extends State<foodFocusPage> {
  List<dynamic> items = new List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final WindowW = MediaQuery.of(context).size.width;
    final WindowH = MediaQuery.of(context).size.height;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(height: WindowH * 8 / 10),
              items: [
                [3, "Hawaiian Pizza"],
                [10, "Hawaiian Pizza"],
                [12, "Hawaiian Pizza"]
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return cardSlider(i[0], i[1]);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

}
