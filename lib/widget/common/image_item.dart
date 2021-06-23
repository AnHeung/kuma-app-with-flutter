import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/image_type.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/common/loading_indicator.dart';

class ImageItem extends StatelessWidget {
  final String imgRes;
  final ImageShapeType type;
  final Key key;
  final double opacity;

  ImageItem({Key key, String imgRes, ImageShapeType type, double opacity})
      : this.type = type ?? ImageShapeType.Circle,
        this.imgRes = imgRes ?? "",
        this.key = key ?? UniqueKey(),
        this.opacity = opacity ?? 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      ImageProvider image;

      ColorFilter colorFilter = opacity > 0
          ? ColorFilter.mode(
          Colors.black.withOpacity(opacity), BlendMode.dstATop)
          : null;

      ImageType imageType = checkImageType(imgRes);

      switch (imageType) {
        case ImageType.File:
          image = FileImage(File(imgRes));
          break;
        case ImageType.Network:
          return _buildNetworkImageContainer(colorFilter: colorFilter, imageRes: imgRes);
        case ImageType.Assets:
          image = AssetImage(imgRes);
          break;
        case ImageType.NoImage:
          image = kNoImage;
          break;
        default:
          image = kNoImage;
          break;
      }
      return _buildDefaultImageContainer(
          colorFilter: colorFilter, image: image);
    }catch(e){
      print('ImageItem exception $e');
      return _buildDefaultImageContainer(image: kNoImage);
    }
  }

  _buildNetworkImageContainer({ColorFilter colorFilter, String imageRes}){

    return CachedNetworkImage(
      imageUrl: imageRes,
      imageBuilder: (context, imageProvider) => _buildDefaultImageContainer(colorFilter: colorFilter, image: imageProvider),
      placeholder: (context, url) =>
      const LoadingIndicator(
        isVisible: true, type: LoadingIndicatorType.IPhone,),
      errorWidget: (context, url, error) =>
          Container(
            child: _buildDefaultImageContainer(
                image: kNoImage, colorFilter: colorFilter),
          ),
    );
  }

  _buildDefaultImageContainer({ColorFilter colorFilter, ImageProvider image}){

    // FadeInImage imageItem = FadeInImage(placeholder: const AssetImage("assets/images/loading.gif"), image: image , imageErrorBuilder:
    //     (context, error, stackTrace) {
    //   return  Container(
    //     child: const Text('Error'),
    //   );
    // },
    //   fit: BoxFit.fill,);
    //
    // return  Container(
    //   constraints: const BoxConstraints.expand(),
    //   decoration: BoxDecoration(
    //     shape: type == ImageShapeType.CIRCLE
    //         ? BoxShape.circle
    //         : BoxShape.rectangle,
    //     image: DecorationImage(
    //         image: image,
    //         onError: (e, stack){
    //           print('_buildDefaultImageContainer DecorationImage error : $e');
    //         },
    //         fit: BoxFit.fill,
    //         colorFilter: colorFilter),
    //   ),
    // );

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        shape: type == ImageShapeType.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        image: DecorationImage(
            image: image,
            onError: (e, stack){
              print('_buildDefaultImageContainer DecorationImage error : $e');
            },
            fit: BoxFit.fill,
            colorFilter: colorFilter),
      ),
    );
  }
}
