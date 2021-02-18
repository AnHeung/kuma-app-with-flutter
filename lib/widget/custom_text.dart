import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  int fontSize;
  Color fontColor;
  bool isDynamic;
  bool isEllipsis;
  int maxLines;

  CustomText(
      {@required this.text,
      fontSize,
      fontColor,
      isDynamic,
      isEllipsis,
      maxLines})
      : this.fontSize = fontSize ?? 13,
        this.fontColor = fontColor ?? Colors.white,
        this.isEllipsis = isEllipsis ?? false,
        this.isDynamic = isDynamic ?? false,
        this.maxLines = maxLines ?? 0;

  @override
  Widget build(BuildContext context) {
    return isDynamic
        ? Text(
            text,
            style: TextStyle(fontSize: fontSize.toDouble(), color: fontColor),
            overflow: isEllipsis ? TextOverflow.ellipsis : null,
            maxLines: maxLines > 0 ? maxLines : null,
          )
        : AutoSizeText(text,
            style: TextStyle(fontSize: fontSize.toDouble(), color: fontColor),
            overflow: isEllipsis ? TextOverflow.ellipsis : null,
            maxLines: maxLines > 0 ? maxLines : null);
  }
}
