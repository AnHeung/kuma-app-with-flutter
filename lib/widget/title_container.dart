import 'package:flutter/widgets.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';

class TitleContainer extends StatelessWidget {

  final String title;
  final Alignment alignment;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;

  const TitleContainer({this.title, alignment ,fontSize, fontFamily,this.fontWeight}) : this.alignment = alignment ?? Alignment.centerLeft ,
        this.fontSize = fontSize?? kAnimationItemTitleFontSize , this.fontFamily = fontFamily ?? doHyunFont ;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
      child: CustomText(
        text: title,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
