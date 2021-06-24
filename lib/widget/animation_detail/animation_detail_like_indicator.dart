part of 'animation_detail_widget.dart';

class AnimationDetailLikeIndicator extends StatelessWidget {
  final double height;
  final String percent;
  final String percentText;
  final Color indicatorColor;

  const AnimationDetailLikeIndicator(
      {this.height, this.percent, this.percentText, this.indicatorColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10),
        alignment: AlignmentDirectional.bottomCenter,
        child: CircularPercentIndicator(
          radius: height,
          lineWidth: 8.0,
          animation: true,
          percent: double.parse(percent),
          center: CustomText(
            fontColor: kWhite,
            text: percentText,
            fontSize: kAnimationDetailIndicatorFontSize,
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: indicatorColor,
        ));
  }
}
