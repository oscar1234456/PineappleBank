import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/home/foodPineapplePage.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'constants.dart';
//cardSlider : card show slider in mainPage

class cardSlider extends StatelessWidget {
  Color colors;
  int i = 0;
  String text = "";

  cardSlider(int choose, String text) {
    this.text = text;
    i = choose;
    // switch(choose){
    //   case choose>=5:
    //     colors = FoodColor.foodColor_level1;
    //     break;
    //   case 2:
    //     colors = FoodColor.foodColor_level2;
    //     break;
    //   default:
    //     colors = FoodColor.foodColor_level3;
    // }
    if (choose >= 12) {
      colors = FoodColor.foodColor_level3;
    } else if (choose >= 5) {
      colors = FoodColor.foodColor_level2;
    } else {
      colors = FoodColor.foodColor_level1;
    }
  }

  final String picLink =
      "https://imageproxy.icook.network/resize?background=255%2C255%2C255&height=675&nocrop=false&stripmeta=true&type=auto&url=http%3A%2F%2Ftokyo-kitchen.icook.tw.s3.amazonaws.com%2Fuploads%2Frecipe%2Fcover%2F216843%2F5867f51c91e53841.jpg&width=1200";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colors,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1200.0,
            height: 180.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/foodPizzaPhoto2.png'),
                  fit: BoxFit.fill),
            ),
          ),
          ListTile(
            title: Text(text,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            // subtitle: Text(
            //   'Secondary Text',
            //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
            // ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Baseline(
                  baseline: 30.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    'Expires in ',
                    style: TextStyle(color: Colors.red, fontSize: 23.0),
                    textAlign: TextAlign.left,
                  ),
                ),
                Baseline(
                  baseline: 34.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '${i} ',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Baseline(
                  baseline: 30.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    'hours',
                    style: TextStyle(color: Colors.red, fontSize: 23.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("I forget to eat this..."),
              ),
              ChoiceChip(
                selectedColor: Color(0xFFbbdefb),
                label: Text('Italian'),
                selected: true,
                onSelected: (bool value) {},
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFffca28),
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => foodPineapplePage()));
                    },
                    child: const Text('Save it!',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
