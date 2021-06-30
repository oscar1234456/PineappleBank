import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/home/PostEditPage.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/services/dataprocess.dart';
import 'package:food_bank_auth/util/styleDesign.dart';

class foodTItem extends StatefulWidget {
  foodTItem(
      {this.location,
        this.intro,
        this.year,
        this.month,
        this.day,
        this.title,
        this.photoUrl});

  final String location;
  final String intro;
  final String year;
  final String month;
  final String day;
  final String photoUrl;
  final String title;

  @override
  _foodTItemState createState() => _foodTItemState();
}
class _foodTItemState extends State<foodTItem> {
  @override
  Widget build(BuildContext context) {
    // final SucceedPost = AlertDialog(
    //   content: Text(
    //     SucceedPostText[2],
    //     style: DiaConStyle,
    //   ),
    //   actions: [
    //     TextButton(
    //       onPressed: () {
    //         Navigator.pop(context);
    //         Navigator.pop(context);
    //       },
    //       child: Text(
    //         OKoptionText,
    //         style: DiaOptDesign[1],
    //       ),
    //     ),
    //   ],
    // );
    final BackBackBtn = TextButton(
      onPressed: (){
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Text(
        OKoptionText,
        style: DiaOptStyle,
      ),
    );
    final SucceedPost = AlertDialog(
      content: Text(
        SucceedPostText[2],
        style: DiaConStyle,
      ),
      actions: [BackBackBtn],
    );
    final PostMyFood = AlertDialog(
      title: Text(
        SucceedPostText[0],
        style: DiaTitleStyle,
      ),
      content: Text(
        "${widget.title} is nearly expired! \n Are you sure to post your food?",
        style: DiaConStyle,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            FoodTracePostDiaOption[0],
            style: DiaOptDesign[0],
          ),
        ),
        TextButton(
          onPressed: () {
            //跳轉至文章編輯頁
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => PostEditPage())
            //     //TODO 取得特定資料放進EditPage
            // );
            showDialog<void>(context: context, builder: (context) => SucceedPost);
          },
          child: Text(
            FoodTracePostDiaOption[1],
            style: DiaOptDesign[1],
          ),
        ),
      ],
    );
    final SucceedFinish = AlertDialog(
      content: Text(
        SucceedFinishText[2],
        style: DiaConStyle,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            OKoptionText,
            style: DiaOptStyle,
          ),
        ),
      ],
    );
    final FinishFood = AlertDialog(
      title: Text(
        SucceedFinishText[0],
        style: DiaTitleStyle,
      ),
      content: Text(
        SucceedFinishText[1],
        style: DiaConStyle,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            FoodTraceFinDiaOption[0],
            style: DiaOptDesign[0],
          ),
        ),
        TextButton(
          onPressed: () {
            //TODO 改變貼文狀態 被解決
            showDialog<void>(
                context: context, builder: (context) => SucceedFinish
            );
          },
          child: Text(
            FoodTraceFinDiaOption[1],
            style: DiaOptDesign[1],
          ),
        ),
      ],
    );
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), //加上一層透明0.5的黑
                BlendMode.dstATop //混合模式，放到上面去
            ),
            image: NetworkImage(widget.photoUrl),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: TitleColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'in ${widget.location}'
                    '\nDate:${widget.year}/${widget.month}/${widget.day}',
                    // '\n${widget.intro.length > 8 ? widget.intro.substring(0, 9) : widget.intro}...',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: ArticleColor, fontWeight: FontWeight.w600),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog<void>(
                        context: context, builder: (context) => PostMyFood);
                  },
                  child: Text(
                    FoodTraceOption[0],
                    overflow: TextOverflow.ellipsis,
                    style: FoodTraceOptionDesign[0],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //TODO: 改變文章狀態並移到History
                    showDialog<void>(
                        context: context, builder: (context) => FinishFood);
                  },
                  child: Text(
                    FoodTraceOption[1],
                    overflow: TextOverflow.ellipsis,
                    style: FoodTraceOptionDesign[1],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//foodTracePage(真的)
Future<List<dynamic>> getData() async {
  print("getFoodData Profilepage");
  var foodPost;
  DataFetch s = DataFetch();
  foodPost = await s.fetchPostdata();
  print(foodPost);
  return foodPost;
}
class foodTracePage extends StatelessWidget {
  List _list = List.generate(16, (index) {
    return index;
  });
  List<Widget> _getGridList() {
    return _list.map((item) {
      return foodTItem();
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 10 / 10,
                ),
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  var location = snapshot.data[index].city;
                  var title = snapshot.data[index].name;
                  var photoUrl = snapshot.data[index].photo;
                  var datetime = DateTime.fromMicrosecondsSinceEpoch(snapshot
                      .data[index].best_before_time.microsecondsSinceEpoch);
                  var year = datetime.year;
                  var month = datetime.month;
                  var day = datetime.day;
                  var intro = snapshot.data[index].introduction;
                  return foodTItem(
                      location: location,
                      intro: intro,
                      year: year.toString(),
                      month: month.toString(),
                      day: day.toString(),
                      title: title,
                      photoUrl: photoUrl);
                },
                //crossAxisSpacing: 10, // 水平距离
                //mainAxisSpacing: 10, // 垂直距离
                //childAspectRatio: 9/10, // 宽高比例
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
    );
  }
}

//eventTracePage(目前還是假的)
class eventItem extends StatelessWidget {
  //沒有intro 小框框塞不下
  eventItem(
      {this.location,
        this.year,
        this.month,
        this.day,
        this.title,
        this.photoUrl});

  final String location;
  final String year;
  final String month;
  final String day;
  final String photoUrl;
  final String title;


  int dateDay = Random().nextInt(5) + 20;

  final eventPhoto = "images/presetE1.png";
  final eventName = "Pick fresh apples!";

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), //加上一層透明0.7的黑
                BlendMode.dstATop //混合模式，放到上面去
            ),
            image: AssetImage(eventPhoto),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                eventName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF8b4513)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'in Taichung......\n'
                    '\nDate:2021/02/${dateDay}'
                    '\nEvaluation : ★★★★☆',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFFb87333)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class eventTracePage extends StatelessWidget {
  List _list = List.generate(5, (index) {
    return index;
  });

  List<Widget> _getGridList() {
    return _list.map((item) {
      return eventItem();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        children: _getGridList(),
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        crossAxisSpacing: 10,// 水平距离
        mainAxisSpacing: 10,// 垂直距离
        childAspectRatio: 10 / 10, // 宽高比例
      ),
    );
  }
}