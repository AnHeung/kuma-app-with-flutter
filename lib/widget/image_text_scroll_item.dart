

import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

class ImageTextScrollItem extends StatelessWidget {

  final String id;
  final String title;
  final String image;
  final ImageShapeType type;
  final int imageDiveRate;
  final BuildContext context;

  ImageTextScrollItem({this.context , this.id, this.title, this.image, type , imageDiveRate}): this.type = type ??  ImageShapeType.FLAT , this.imageDiveRate = imageDiveRate ?? 3;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / imageDiveRate;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
            arguments: AnimationDetailPageItem(
                id: id, title: title));
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
                  type: type,
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