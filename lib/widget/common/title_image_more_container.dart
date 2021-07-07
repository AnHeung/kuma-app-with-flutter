import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/common/empty_container.dart';
import 'package:kuma_flutter_app/widget/common/image_text_scroll_item.dart';
import 'package:kuma_flutter_app/widget/common/more_container.dart';
import 'package:kuma_flutter_app/widget/common/title_container.dart';

class TitleImageMoreContainer extends StatelessWidget {
  final List<BaseScrollItem> baseItemList;
  final ImageShapeType imageShapeType;
  final VoidCallback onClick;
  final int imageDiveRate;
  final String categoryTitle;
  final double height;

  const TitleImageMoreContainer(
      {List<BaseScrollItem> baseItemList,
      imageShapeType,
      imageDiveRate,
      this.onClick,
      this.categoryTitle,
      this.height})
      : this.baseItemList = baseItemList ?? const <BaseScrollItem>[],
        this.imageShapeType = imageShapeType ?? ImageShapeType.Circle,
        this.imageDiveRate = imageDiveRate ?? 3;

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
                    onClick: onClick,
                  ))
            ],
          ),
          _isSizeEnough
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: _getPictureList(
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
                  size: height,
                )
        ],
      ),
    );
  }

  bool get _isSizeEnough => baseItemList != null && baseItemList.length != 0;

  int get limitCount => baseItemList.length < 10 ? baseItemList.length : 10;

  Widget _getPictureList(
      {BuildContext context , double height,  int length, Function builderFunction}) {
    return Container(
      height: height,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: separatorBuilder(context: context),
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: length,
          shrinkWrap: true,
          itemBuilder: builderFunction),
    );
  }
}
