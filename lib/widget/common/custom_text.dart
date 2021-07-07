import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final String fontFamily;
  final bool isDynamic;
  final bool isEllipsis;
  final int maxLines;
  final TextAlign textAlign;

  CustomText({
    @required this.text,
    fontSize,
    fontColor,
    fontFamily,
    isDynamic,
    isEllipsis,
    maxLines,
    fontWeight,
    textAlign,
  })  : this.fontSize = fontSize ?? kDefaultFontSize,
        this.fontColor = fontColor ?? kBlack,
        this.fontFamily = fontFamily ?? nanumGothicFont,
        this.isEllipsis = isEllipsis ?? false,
        this.isDynamic = isDynamic ?? false,
        this.maxLines = maxLines ?? 0,
        this.fontWeight = fontWeight ?? FontWeight.normal,
        this.textAlign = textAlign ?? TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return isDynamic
        ? AutoSizeText(
            text,
            style: TextStyle(
              fontSize: fontSize,
                fontFamily: fontFamily,
                color: fontColor,
                fontWeight: fontWeight),
            overflow: isEllipsis ? TextOverflow.ellipsis : null,
            maxLines: maxLines > 0 ? maxLines : null,
            textAlign: textAlign,
          )
        : Text(text,
            style: TextStyle(
                fontFamily: fontFamily,
                fontSize: fontSize,
                color: fontColor,
                fontWeight: fontWeight),
            overflow: isEllipsis ? TextOverflow.ellipsis : null,
            maxLines: maxLines > 0 ? maxLines : null,
            textAlign: textAlign);
  }
}
