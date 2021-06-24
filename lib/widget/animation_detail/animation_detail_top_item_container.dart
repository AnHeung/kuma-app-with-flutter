part of 'animation_detail_widget.dart';

class AnimationDetailTopItemContainer extends StatelessWidget {
  final double fontSize;
  final String text;
  final FontWeight fontWeight;

  AnimationDetailTopItemContainer({this.fontSize, this.text, this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
          alignment: Alignment.center,
          child: CustomText(
            textAlign: TextAlign.center,
            text: text,
            fontSize: fontSize,
            fontColor: kWhite,
            fontFamily: doHyunFont,
            fontWeight: fontWeight,
            maxLines: 2,
            isEllipsis: true,
            isDynamic: true,
          )),
    );
  }
}
