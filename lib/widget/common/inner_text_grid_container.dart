import 'package:flutter/widgets.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';
import 'package:kuma_flutter_app/widget/common/image_item.dart';

class InnerTextGridContainer extends StatelessWidget {
  final List<BaseScrollItem> list;
  final int gridCount;
  final ImageShapeType imageShapeType;

  const InnerTextGridContainer({this.list,  gridCount , imageShapeType}) : this.gridCount = gridCount?? 3 ,this.imageShapeType = imageShapeType?? ImageShapeType.Circle;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: list.isNotEmpty,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: gridCount,
              scrollDirection: Axis.vertical,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              children: list
                  .map((item) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: item.onTap,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: ImageItem(
                          type: imageShapeType,
                          imgRes: item.image,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 90,
                        height: 90,
                        child: CustomText(
                          fontFamily: doHyunFont,
                          fontSize: 10.0,
                          textAlign: TextAlign.center,
                          fontColor: kWhite,
                          text: item.title,
                          maxLines: 2,
                          isEllipsis: true,
                          isDynamic: true,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .toList()),
        ));
  }
}