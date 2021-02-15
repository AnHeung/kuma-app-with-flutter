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

  ImageItem({Key key , this.imgRes , ImageShapeType type}) : this.type = type ?? ImageShapeType.CIRCLE , this.key = key?? UniqueKey() , super(key:key);

  @override
  State<ImageItem> createState(){
    ImageType imageType = checkImageType(imgRes);
    switch(imageType){
      case ImageType.FILE :return _FileImageState();
      case ImageType.NETWORK :return _NetImageState();
      case ImageType.NO_IMAGE :return _NoImageState();
      default: return _NoImageState();
    }
  }
}

class _FileImageState extends State<ImageItem> {
  @override
  Widget build(BuildContext context) {
    return widget.type == ImageShapeType.CIRCLE ?
    CircleAvatar(
        radius: 55,
        backgroundColor: Color(0xffFDCF09),
        child: CircleAvatar(radius: 50, backgroundImage: FileImage(File(widget.imgRes))))
        :   Image.file(File(widget.imgRes));
  }
}
// Image.network(widget.imgRes, fit: BoxFit.cover),
class _NetImageState extends State<ImageItem> {
  @override
  Widget build(BuildContext context) {
    return widget.type == ImageShapeType.CIRCLE ?
    CircleAvatar(
      radius: 55,
      backgroundColor: Color(0xffFDCF09),
      child: CircleAvatar(radius: 50, backgroundImage: NetworkImage(widget.imgRes)))
        :   Image.network(widget.imgRes, fit: BoxFit.cover);
  }
}

class _NoImageState extends State<ImageItem> {
  @override
  Widget build(BuildContext context) {

    return widget.type == ImageShapeType.CIRCLE ?
    CircleAvatar(
      radius: 55,
      backgroundColor: Color(0xffFDCF09),
      child: CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/images/no_image.png'),),)
        :  Image(fit: BoxFit.cover, image: AssetImage('assets/images/no_image.png' ,),);
  }
}
