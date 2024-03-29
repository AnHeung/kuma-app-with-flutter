import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/widget/common/image_item.dart';

class Pages extends StatefulWidget {

  PageState createState() => PageState();

}

class PageState extends State<Pages>{

  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('PageView Widget in Flutter')),
        body: Center(child:
        PageView(
          controller: controller,
          onPageChanged: (page)=>{ print(page.toString()) },
          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
                color: Colors.pink,
                child: Center(
                    child: ImageItem(type: ImageShapeType.Flat , imgRes: "https://api-cdn.myanimelist.net/images/anime/1598/110462l.jpg",))
            ),

            Container(
                color: Colors.green,
                child: const Center(
                    child: Text('This is Widget - 2',
                      style: TextStyle(fontSize: 25,
                          color: kWhite),))
            ),

            Container(
                color: Colors.lightBlue,
                child: const Center(
                    child: Text('This is Widget - 3',
                      style: TextStyle(fontSize: 25,
                          color: kWhite),))
            ),

          ],
        ),

        )
    );
  }
}