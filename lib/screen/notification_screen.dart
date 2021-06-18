import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/notification/notification_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/model/item/notification_item.dart';
import 'package:kuma_flutter_app/screen/animation_news_detail_screen.dart';
import 'package:kuma_flutter_app/util/navigator_util.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/util/object_util.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: kWhite,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: '알림내역',
          fontColor: kBlack,
          fontFamily: doHyunFont,
          fontSize: 20.0,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            BlocProvider.of<NotificationBloc>(context).add(NotificationLoad()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {

            List<NotificationItem> items = state.notificationItems;

            if (items.isNullOrEmpty) {
              return const EmptyContainer(
                title: "알림 내역이 없습니다.",
              );
            } else if (state.status == NotificationStatus.Failure) {
              showToast(msg: state.msg);
            }else if(state.status == NotificationStatus.NetworkError){
              return RefreshContainer(
                callback: () => BlocProvider.of<NotificationBloc>(context)
                    .add(NotificationLoad()),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  ListView.separated(
                    separatorBuilder: (context, idx) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, idx) {
                      final NotificationItem notificationItem = items[idx];
                      return NotificationContainerItem(
                        item: notificationItem,
                      );
                    },
                    itemCount: items.length,
                    scrollDirection: Axis.vertical,
                  ),
                  LoadingIndicator(isVisible: state.status == NotificationStatus.Loading,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class NotificationContainerItem extends StatelessWidget {
  final NotificationItem item;

  const NotificationContainerItem({this.item});

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
                    type: ImageShapeType.FLAT,
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
