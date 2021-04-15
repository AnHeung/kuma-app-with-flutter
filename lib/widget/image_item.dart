import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/image_type.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';

class ImageItem extends StatefulWidget {

   final String imgRes;
   final ImageShapeType type;
   final Key key;
   final double opacity;

  ImageItem({Key key , String imgRes , ImageShapeType type, double opacity}) : this.type = type ?? ImageShapeType.CIRCLE , this.imgRes = imgRes ?? "", this.key = key?? UniqueKey() , this.opacity = opacity?? 0 , super(key:key);

  @override
  State<ImageItem> createState()=>_ImageState();

}


class _ImageState extends State<ImageItem> {
  @override
  Widget build(BuildContext context) {

    ImageType imageType = checkImageType(widget.imgRes);
    ColorFilter colorFilter =  widget.opacity > 0 ? ColorFilter.mode(Colors.black.withOpacity(widget.opacity), BlendMode.dstATop) : null;
    var image;

    switch(imageType){
      case ImageType.FILE : image = FileImage(File(widget.imgRes));
          break;
      case ImageType.NETWORK : image= NetworkImage(widget.imgRes);
          break;
      case ImageType.ASSETS : image= AssetImage(widget.imgRes);
      break;
      case ImageType.NO_IMAGE : image=  const AssetImage('assets/images/no_image.png',);
        break;
      default : image = const AssetImage('assets/images/no_image.png' ,);
        break;
    }

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
          shape: widget.type == ImageShapeType.CIRCLE ? BoxShape.circle: BoxShape.rectangle ,
          image:  DecorationImage(
              colorFilter: colorFilter,
              fit: BoxFit.fill,
              image:  image,
          )
      ) ,
    ); Image.file(File(widget.imgRes));
  }
}
