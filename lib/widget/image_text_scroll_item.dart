import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

class ImageTextScrollItemContainer extends StatelessWidget {

  final BaseScrollItem baseScrollItem;
  final BuildContext context;
  final ImageShapeType imageShapeType;
  final int imageDiveRate;

  ImageTextScrollItemContainer({this.context ,this.baseScrollItem, imageShapeType , imageDiveRate}) : this.imageShapeType = imageShapeType?? ImageShapeType.CIRCLE , this.imageDiveRate = imageDiveRate ?? 3;

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
                      baseScrollItem.score.isNotEmpty ? Container(
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                          alignment: AlignmentDirectional.bottomStart,
                          child:  Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:Border.all(width: 2, color: (_setIndicatorColor(score : (double.parse(baseScrollItem.score)) * 10))),
                                borderRadius: BorderRadius.circular(30),
                                color: kBlack,
                              ),
                              child: CustomText(
                                fontFamily: doHyunFont,
                                fontWeight: FontWeight.w700,
                                fontColor: kWhite,
                                text: "${((double.parse(baseScrollItem.score)) * 10).toStringAsFixed(0)}%",
                                fontSize: 10.0,
                              ),
                            ),
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