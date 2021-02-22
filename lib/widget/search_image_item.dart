import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/image_type.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

class SearchImageItem extends StatelessWidget {

  String title;
  String imgRes;

  SearchImageItem({this.imgRes , this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10 , right: 10),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ImageItem(type:ImageShapeType.CIRCLE , imgRes:imgRes)
          ,ImageItem(type:ImageShapeType.CIRCLE , imgRes:imgRes)
        ],
      ),
    );
  }
}
