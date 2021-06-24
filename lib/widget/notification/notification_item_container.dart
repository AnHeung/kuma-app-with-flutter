part of 'notification_widget.dart';

class NotificationItemContainer extends StatelessWidget {
  final NotificationItem item;

  const NotificationItemContainer({this.item});

  @override
  Widget build(BuildContext context) {

    final bool isRead = item.isRead ?? false;
    final String id = item.id ?? "";

    return GestureDetector(
      onTap: (){
        BlocProvider.of<NotificationBloc>(context).add(NotificationIsReadUpdate(id: id));
        navigateWithUpAnimation(context: context , navigateScreen: AnimationNewsDetailScreen(AnimationNewsItem(date: item.date ,summary: item.summary ,title: item.title , imageUrl: item.image , url: item.url)));
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        color: isRead ? kDisabled : kWhite,
        height: kNotificationItemHeight,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: kNotificationMargin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  width: kNotificationItemWidth,
                  height: kNotificationItemHeight,
                  child: ImageItem(
                    imgRes: item.thumbnail,
                    type: ImageShapeType.Flat,
                  )),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(left: kNotificationMargin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: CustomText(
                          text: "[${item.mainTitle}]",
                          maxLines: 1,
                          isEllipsis: true,
                          fontSize: kNotificationTitleFontSize,
                          fontFamily: doHyunFont,
                          fontWeight: FontWeight.w500,
                        )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: CustomText(
                        text: "${item.summary}",
                        maxLines: 3,
                        isDynamic: true,
                        isEllipsis: true,
                        fontSize: kNotificationFontSize,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: kNotificationTitleImageSize,
                    height: kNotificationTitleImageSize,
                    child: ImageItem(
                      imgRes: item.image,
                    )))
          ],
        ),
      ),
    );
  }
}