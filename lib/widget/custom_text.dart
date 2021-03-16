import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final bool isDynamic;
  final bool isEllipsis;
  final int maxLines;

  CustomText(
      {@required this.text,
      fontSize,
      fontColor,
      isDynamic,
      isEllipsis,
      maxLines,
      fontWeight})
      : this.fontSize = fontSize ?? 13,
        this.fontColor = fontColor ?? Colors.white,
        this.isEllipsis = isEllipsis ?? false,
        this.isDynamic = isDynamic ?? false,
        this.maxLines = maxLines ?? 0,
        this.fontWeight = fontWeight ?? FontWeight.normal;

  @override
  Widget build(BuildContext context) {
    return isDynamic
        ? AutoSizeText(text,
            style: TextStyle(
                fontSize: fontSize.toDouble(),
                color: fontColor,
                fontWeight: fontWeight),
            overflow: isEllipsis ? TextOverflow.ellipsis : null,
            maxLines: maxLines > 0 ? maxLines : null)
        : Text(
            text,
            style: TextStyle(
                fontSize: fontSize.toDouble(),
                color: fontColor,
                fontWeight: fontWeight),
            overflow: isEllipsis ? TextOverflow.ellipsis : null,
            maxLines: maxLines > 0 ? maxLines : null,
          );
  }
}
