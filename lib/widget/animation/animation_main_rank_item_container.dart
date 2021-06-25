part of 'animation_widget.dart';

class AnimationMainRankItemContainer extends StatelessWidget {

  final AnimationMainItem item;

  const AnimationMainRankItemContainer({this.item});

  @override
  Widget build(BuildContext context) {
    double heightSize = (MediaQuery.of(context).size.height) * kAnimationRankingContainerHeightRate;

    return Container(
      height: heightSize,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TitleContainer(
                fontWeight: FontWeight.w700, title: item.koreaType),
          ),
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              children: item.list
                  .map(
                    (rankItem) => ImageTextScrollItemContainer(
                    imageShapeType: ImageShapeType.Flat,
                    imageDiveRate: 3,
                    context: context,
                    baseScrollItem: BaseScrollItem(
                      title: rankItem.title,
                      id: rankItem.id.toString(),
                      image: rankItem.image,
                      score: rankItem.score,
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.IMAGE_DETAIL,
                        arguments: AnimationDetailPageItem(
                            id: rankItem.id, title: rankItem.title),
                      ),
                    )),
              )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
