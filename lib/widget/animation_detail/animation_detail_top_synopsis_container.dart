part of 'animation_detail_widget.dart';

class AnimationDetailSynopsisContainer extends StatelessWidget {

  final AnimationDetailItem detailItem;

  const AnimationDetailSynopsisContainer({this.detailItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleContainer(title: kAnimationDetailSynopsisTitle),
         Container(
          child: CustomText(
            fontSize: kAnimationDetailFontSize,
            text: detailItem.synopsis,
            fontColor: kBlack,
          ),
          margin: const EdgeInsets.only(left: 10, top: 10),
        ),
      ],
    );
  }
}
