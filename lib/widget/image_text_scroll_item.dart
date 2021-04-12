

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/navigation_push_type.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ImageTextScrollItem extends StatelessWidget {

  final String id;
  final String title;
  final String image;
  final String score;
  final ImageShapeType imageShapeType;
  final int imageDiveRate;
  final BuildContext context;
  final NavigationPushType pushType;

  ImageTextScrollItem({this.context , this.id, this.title, this.image, score , imageShapeType , imageDiveRate , pushType}): this.imageShapeType = imageShapeType ??  ImageShapeType.FLAT , this.imageDiveRate = imageDiveRate ?? 3 , this.pushType = pushType?? NavigationPushType.PUSH , this.score = score ?? "";

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
                  child: Stack(
                    children: [
                      Container(
                        child: ImageItem(
                          imgRes: image,
                          type: imageShapeType,
                        ),
                      ),
                      score.isNotEmpty ? Container(
                        padding: EdgeInsets.only(left: 5, bottom: 5),
                          alignment: AlignmentDirectional.bottomStart,
                          child:  Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:Border.all(width: 2, color: (_setIndicatorColor(score : (double.parse(score)) * 10))),
                                borderRadius: BorderRadius.circular(30),
                                color: kBlack,
                              ),
                              child: CustomText(
                                fontFamily: doHyunFont,
                                fontWeight: FontWeight.w700,
                                fontColor: kWhite,
                                text: "${((double.parse(score)) * 10).toStringAsFixed(0)}%",
                                fontSize: 10.0,
                              ),
                            ),
                          ) : SizedBox()
                    ],
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

  _setIndicatorColor({double score}){
    if(score < 100  && score > 80){
      return kGreen;
    }else if(score < 80 && score > 60){
      return kPurple;
    }else if(score < 60 && score > 40){
      return Colors.yellow;
    }
      return Colors.red;
  }
}