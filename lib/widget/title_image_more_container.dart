import 'package:flutter/widgets.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_text_scroll_item.dart';
import 'package:kuma_flutter_app/widget/more_container.dart';
import 'package:kuma_flutter_app/widget/title_container.dart';

class TitleImageMoreContainer extends StatelessWidget {
  final List<BaseScrollItem> baseItemList;
  final ImageShapeType imageShapeType;
  final int imageDiveRate;
  final String categoryTitle;
  final VoidCallback moreOnClick;
  final double height;

  const TitleImageMoreContainer(
      {List<BaseScrollItem> baseItemList,
        imageShapeType, imageDiveRate,
      this.categoryTitle,
      this.moreOnClick,
      this.height})
      : this.baseItemList = baseItemList ?? const <BaseScrollItem>[] , this.imageShapeType = imageShapeType?? ImageShapeType.CIRCLE , this.imageDiveRate = imageDiveRate ?? 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TitleContainer(
                title: categoryTitle,
              ),
              const Spacer(),
              Visibility(
                  visible: _isSizeEnough,
                  child: MoreContainer(
                    onClick: moreOnClick,
                  ))
            ],
          ),
          _isSizeEnough
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: _getPictureList(
                      margin: 10,
                      height: height,
                      length: limitCount,
                      builderFunction: (BuildContext context, idx) {
                        final BaseScrollItem item = baseItemList[idx];
                        return ImageTextScrollItemContainer(
                          imageShapeType: imageShapeType,
                          imageDiveRate: imageDiveRate,
                          context: context,
                          baseScrollItem: BaseScrollItem(
                              id: item.id.toString(),
                              title: item.title,
                              image: item.image,
                              onTap: item.onTap),
                        );
                      }),
                )
              : EmptyContainer(
                  title: "${categoryTitle} 정보 없음",
                  size: 100,
                )
        ],
      ),
    );
  }

  bool get _isSizeEnough =>baseItemList!= null && baseItemList.length !=0;

  int get limitCount => baseItemList.length < 10 ? baseItemList.length : 10;

  Widget _getPictureList(
      {double height, double margin, int length, Function builderFunction}) {
    return Container(
      height: height,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: margin,
            );
          },
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: length,
          shrinkWrap: true,
          itemBuilder: builderFunction),
    );
  }
}