import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/common/empty_container.dart';
import 'package:kuma_flutter_app/widget/common/image_item.dart';

class ImageScrollItemContainer extends StatelessWidget {
  final List<String> images;
  final String title;
  final double height;

  ImageScrollItemContainer({images , this.title , height}) : this.images = images ?? [] , this.height = height ?? 150;

  @override
  Widget build(BuildContext context) {
    return !images.isNullOrEmpty ? Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10),
      child: _getImagesContainer(
          height: height,
          margin: 10,
          length: images.length,
          builderFunction: (BuildContext context, idx) {
            final String imgRes = images[idx];
            return AspectRatio(
              aspectRatio: 0.8,
              child: GestureDetector(
                onTap: () => showImageDialog(context, imgRes, images, idx),
                child: ImageItem(
                  imgRes: imgRes,
                  type: ImageShapeType.Flat,
                ),
              ),
            );
          }),
    ) : EmptyContainer(title: "$title 없음",);
  }

  Widget _getImagesContainer(
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
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: length,
          shrinkWrap: true,
          itemBuilder: builderFunction),
    );
  }
}
