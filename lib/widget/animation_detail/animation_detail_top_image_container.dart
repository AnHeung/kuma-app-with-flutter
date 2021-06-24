part of 'animation_detail_widget.dart';

class AnimationDetailTopImageContainer extends StatelessWidget {

  final AnimationDetailItem detailItem;
  const AnimationDetailTopImageContainer({this.detailItem});

  @override
  Widget build(BuildContext context) {
    final double topHeight = MediaQuery.of(context).size.height * kTopImageContainerHeightRate;
    final double imageItemWidth = MediaQuery.of(context).size.width * kTopImageWidthRate;

    return Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: topHeight,
            child: ImageItem(
              opacity: 0.8,
              imgRes: detailItem.image,
              type: ImageShapeType.Flat,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: imageItemWidth,
            height: topHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => showImageDialog(context, detailItem.title, [detailItem.image], 0),
                    child: Container(
                      height: topHeight,
                      child: Hero(
                        tag: "animation-detail-hero${detailItem.id}",
                        child: ImageItem(
                          type: ImageShapeType.Flat,
                          imgRes: detailItem.image,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
