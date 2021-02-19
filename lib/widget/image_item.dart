import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/enums/image_type.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';

// ignore: must_be_immutable
class ImageItem extends StatefulWidget {

   final String imgRes;
   final ImageShapeType type;
   final Key key;
   final double opacity;

  ImageItem({Key key , this.imgRes , ImageShapeType type, double opacity}) : this.type = type ?? ImageShapeType.CIRCLE , this.key = key?? UniqueKey() , this.opacity = opacity?? 0 , super(key:key);

  @override
  State<ImageItem> createState()=>_ImageState();

}


class _ImageState extends State<ImageItem> {
  @override
  Widget build(BuildContext context) {

    ImageType imageType = checkImageType(widget.imgRes);

    var image;

    switch(imageType){
      case ImageType.FILE : image = FileImage(File(widget.imgRes));
          break;
      case ImageType.NETWORK : image= NetworkImage(widget.imgRes);
          break;
      case ImageType.NO_IMAGE : image=  AssetImage('assets/images/no_image.png' ,);
        break;
      default : image = AssetImage('assets/images/no_image.png' ,);
        break;
    }

    return widget.type == ImageShapeType.CIRCLE ?
    CircleAvatar(
        radius: 55,
        backgroundColor: Color(0xffFDCF09),
        child: CircleAvatar(radius: 50, backgroundImage: FileImage(File(widget.imgRes))))
        :  Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: widget.opacity > 0 ? ColorFilter.mode(Colors.black.withOpacity(widget.opacity), BlendMode.dstATop) : null,
            image: image, fit: BoxFit.fitHeight),
      ),
    ); Image.file(File(widget.imgRes));
  }
}
