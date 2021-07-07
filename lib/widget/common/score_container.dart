import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';

class ScoreContainer extends StatelessWidget {

  final String score;
  final Color color;

  const ScoreContainer({this.score, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, bottom: 5),
      alignment: AlignmentDirectional.bottomStart,
      child:  Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:Border.all(width: 2, color: color),
          borderRadius: BorderRadius.circular(30),
          color: kBlack,
        ),
        child: CustomText(
          fontFamily: doHyunFont,
          fontWeight: FontWeight.w700,
          fontColor: kWhite,
          text: "${((double.parse(score)) * 10).toStringAsFixed(0)}%",
          fontSize: 10.0,
        ),
      ),
    );
  }
}
