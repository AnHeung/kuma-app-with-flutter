part of 'search_widget.dart';

class SearchImageItemContainer extends StatelessWidget {
  final String title;
  final String imgRes;
  final GestureTapCallback onTap;

  SearchImageItemContainer({this.imgRes, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kSearchItemContainerSymmetricMargin),
        height: kSearchImageItemContainerHeight,
        child: Row(
          children: [
            Container(
                width: kSearchImageItemSize,
                height: kSearchImageItemSize,
                child: ImageItem(type: ImageShapeType.Circle, imgRes: imgRes)),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: CustomText(
                fontColor: Colors.white,
                text: title,
                isEllipsis: true,
                isDynamic: true,
                maxLines: 1,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
