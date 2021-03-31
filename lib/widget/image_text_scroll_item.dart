

import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/navigation_push_type.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

class ImageTextScrollItem extends StatelessWidget {

  final String id;
  final String title;
  final String image;
  final ImageShapeType imageShapeType;
  final int imageDiveRate;
  final BuildContext context;
  final NavigationPushType pushType;

  ImageTextScrollItem({this.context , this.id, this.title, this.image, imageShapeType , imageDiveRate , pushType}): this.imageShapeType = imageShapeType ??  ImageShapeType.FLAT , this.imageDiveRate = imageDiveRate ?? 3 , this.pushType = pushType?? NavigationPushType.PUSH;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / imageDiveRate;

    return GestureDetector(
      onTap: () {
        switch(pushType){
          case  NavigationPushType.PUSH:
            Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
                arguments: AnimationDetailPageItem(
                    id: id, title: title));
            break;
          case  NavigationPushType.REPLACE:
            Navigator.pushReplacementNamed(context, Routes.IMAGE_DETAIL,
                arguments: AnimationDetailPageItem(
                    id: id, title: title));
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 8, bottom: 8),
        width: width,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: ImageItem(
                  imgRes: image,
                  type: imageShapeType,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 10),
                child: CustomText(
                  fontWeight: FontWeight.w700,
                  fontColor: kBlack,
                  text: title,
                  maxLines: 2,
                  isDynamic: true,
                  isEllipsis: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}