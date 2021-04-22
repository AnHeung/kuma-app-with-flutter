import 'package:flutter/widgets.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';

class MoreContainer extends StatelessWidget {

  final VoidCallback onClick;
  final double fontSize;
  final double margin;

  MoreContainer({this.onClick, fontSize , margin}) : this.fontSize = fontSize , this.margin = margin ?? 10;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: CustomText(
          text: "더보기 > ",
          fontFamily: doHyunFont,
          fontWeight: FontWeight.w700,
          fontSize: 13.0,
          fontColor: kGrey,
        ),
      ),
    );
  }
}
