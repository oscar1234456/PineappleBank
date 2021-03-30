import 'package:flutter/material.dart';
import 'package:food_bank_auth/models/event.dart';
import 'package:food_bank_auth/models/food.dart';
import 'package:food_bank_auth/screens/home/container_transition.dart';
import 'constants.dart';
import 'package:animations/animations.dart';

class inkWellFoodCardList extends StatelessWidget {
  inkWellFoodCardList({Key key, this.openContainer, this.data})
      : super(key: key);
  final Food data;
  final VoidCallback openContainer;

  String content = "";

  @override
  Widget build(BuildContext context) {
    var datetime = DateTime.fromMicrosecondsSinceEpoch(
        data.best_before_time.microsecondsSinceEpoch);
    var year = datetime.year;
    var month = datetime.month;
    var day = datetime.day;
    var hour = datetime.hour;
    var minute = datetime.minute;
    //TODO: 測試用資料，模擬不同顏色、字串
    // if (data.length>90){
    //   color = FoodColor.foodColor_level2;
    //   content = data.substring(1,25)+"...";
    // }else{
    //   color = FoodColor.foodColor_level1;
    //   content = data.substring(1,20);
    // }
    return _InkWellOverlay(
      openContainer: openContainer,
      child: Card(
        elevation: 0,
        color: BGColor,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image(
                image: NetworkImage(data.photo),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(data.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.0),
                  //TODO: 當只剩3小時，開始以顏色標記、縮寫成到期前倒數
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        size: 13,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 3,
                      ),
                      Text(
                        "${year}・${month}・${day}",
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 13,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 3,
                      ),
                      Text(
                        "${hour < 10 ? "0" + hour.toString() : hour}:${minute < 10 ? "0" + minute.toString() : minute}",
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.openContainer,
    this.width,
    this.height,
    this.child,
  });

  final VoidCallback openContainer;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}
