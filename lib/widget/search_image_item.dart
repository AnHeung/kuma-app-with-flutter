import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/image_type.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

class SearchImageItem extends StatelessWidget {
  final String title;
  final String imgRes;
  final GestureTapCallback onTap;

  SearchImageItem({this.imgRes, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        height: 80,
        child: Row(
          children: [
            Container(
                width: 40,
                height: 40,
                child: ImageItem(type: ImageShapeType.CIRCLE, imgRes: imgRes)),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 30),
              child: CustomText(
                fontColor: Colors.white,
                fontSize: 15,
                text: title,
                isEllipsis: true,
                isDynamic: true,
                maxLines: 1,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
