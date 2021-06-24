part of 'animation_detail_widget.dart';

class AnimationDetailTopSynopsisContainer extends StatelessWidget {

  final AnimationDetailItem detailItem;

  const AnimationDetailTopSynopsisContainer({this.detailItem});

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
