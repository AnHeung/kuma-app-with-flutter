import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/notification/notification_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/notification_item.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/util/object_util.dart';
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
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          List<NotificationItem> items = state.notificationItems;

          if (items.isNullOrEmpty) {
            return const EmptyContainer(
              title: "알림 내역이 없습니다.",
            );
          } else if (state.status == NotificationStatus.Failure) {
            return RefreshContainer(
              callback: () => BlocProvider.of<NotificationBloc>(context)
                  .add(NotificationLoad()),
            );
          }
          return ListView.separated(
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
          );
        },
      ),
    );
  }
}

class NotificationContainerItem extends StatelessWidget {
  final NotificationItem item;

  const NotificationContainerItem({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 70,
              height: 100,
              child: ImageItem(
                imgRes: item.thumbnail,
                type: ImageShapeType.FLAT,
              )),
          Container(
            padding: const EdgeInsets.only(left:10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: CustomText(
                      text: "[${item.mainTitle}]",
                      maxLines: 1,
                      isEllipsis: true,
                      fontSize: 16.0,
                      fontFamily: doHyunFont,
                      fontWeight: FontWeight.w700,
                    )),
                Container(
                  height: 70,
                  width: 200,
                  child: CustomText(
                    text: "${item.summary}",
                    maxLines: 3,
                    isDynamic: true,
                    isEllipsis: true,
                    fontSize: 13.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
