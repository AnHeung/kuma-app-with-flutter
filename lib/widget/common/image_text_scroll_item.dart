import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';
import 'package:kuma_flutter_app/widget/common/image_item.dart';
import 'package:kuma_flutter_app/widget/common/score_container.dart';

class ImageTextScrollItemContainer extends StatelessWidget {

  final BaseScrollItem baseScrollItem;
  final BuildContext context;
  final ImageShapeType imageShapeType;
  final int imageDiveRate;

  ImageTextScrollItemContainer({this.context ,this.baseScrollItem, imageShapeType , imageDiveRate}) : this.imageShapeType = imageShapeType?? ImageShapeType.Circle , this.imageDiveRate = imageDiveRate ?? kDefaultImageDiveRate;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / imageDiveRate;

    return GestureDetector(
      onTap:baseScrollItem.onTap,
      child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            width: width,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      Container(
                        child: ImageItem(
                          imgRes: baseScrollItem.image,
                          type: imageShapeType,
                        ),
                      ),
                      baseScrollItem.score.isNotEmpty ? ScoreContainer(
                        color: _setIndicatorColor(score : (double.parse(baseScrollItem.score)) * 10),
                        score: baseScrollItem.score,
                      ) : const SizedBox()
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(top: 10),
                    child: CustomText(
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      fontColor: kBlack,
                      text: baseScrollItem.title,
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