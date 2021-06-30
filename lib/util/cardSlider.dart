import 'package:flutter/material.dart';
import 'package:food_bank_auth/util/presetItem.dart';
import 'package:food_bank_auth/util/styleDesign.dart';
import 'package:food_bank_auth/util/styleDesignImg.dart';
//cardSlider : card show slider in foodFocusPage

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
    final WindowW = MediaQuery.of(context).size.width;
    // final WindowH = MediaQuery.of(context).size.height;
    return Card(
      color: colors,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: WindowW * 8 / 10,
            height: WindowW * 7 / 10,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(PizzaBrownBGImgPath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Container(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                "$text",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Baseline(
                  baseline: 30.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    'Expires in ',
                    style: TextStyle(color: Colors.red, fontSize: 25.0),
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
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Baseline(
                  baseline: 30.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    'hours',
                    style: TextStyle(color: Colors.red, fontSize: 25.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Container(
              decoration: BoxDecoration(
                  // border: new Border.all(color: Colors.black, width: 0.5),
                  // color: Colors.red[400],
                borderRadius: new BorderRadius.circular((20.0)),

              ),
              child: Text(
                "\n\n\nHand-made Hawaiian Pizza(๑•̀ㅂ•́)و✧\n"
                "\nCRISPY pie crust and FULL of ingredients\n\n\n\n",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("images/ic_launcher_smile.png",
                height: 50,
              ),
              SizedBox(width: 20,),
              ChoiceChip(
                selectedColor: Pineapple50,
                label: Text(
                  'Italian',
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
                selected: true,
                onSelected: (bool value) {},
              ),ChoiceChip(
                selectedColor: Pineapple50,
                label: Text(
                  'Pizza',
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
                selected: true,
                onSelected: (bool value) {},
              ),

              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 40),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => foodPineapplePage()));
                    },
                    child: Text(
                      'Save it!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
