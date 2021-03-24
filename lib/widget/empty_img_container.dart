import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

class EmptyImgContainer extends StatelessWidget {

  String title;
  String imgRes;

  EmptyImgContainer({this.title, this.imgRes}){
    print(title);
    print(imgRes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 350,
      color: kWhite,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: CustomText(
                text: title,
                fontSize: 20,
                fontColor: Colors.grey,
              ),
            ),
            Expanded(
              child: ImageItem(
                type: ImageShapeType.FLAT,
                imgRes: imgRes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
