import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/animation_detail/animation_detail_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_item.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';

class BottomVideoItemContainer extends StatelessWidget {
  final AnimationDetailItem detailItem;
  final List<VideoItem> videoItems;
  final AnimationDetailBloc bloc;

  BottomVideoItemContainer({this.detailItem, @required this.bloc})
      : this.videoItems = detailItem != null && detailItem.videoItems != null
            ? detailItem.videoItems
            : [];

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 50;
    const double titleHeight = 60;
    final double maxHeight = MediaQuery.of(context).size.height / 2;
    final height = videoItems.length * itemHeight > maxHeight ? maxHeight :  videoItems.length *itemHeight  + itemHeight *2 + titleHeight;

    return Container(
      color: kBlack,
      constraints: BoxConstraints(
          minHeight: itemHeight,
          minWidth: double.infinity,
          maxHeight:height),
      child: Column(
          children: [
            Container(padding: const EdgeInsets.only(top: 20, bottom: 10), height: titleHeight, child: CustomText(text: "비디오 목록", fontColor: kWhite,fontFamily: doHyunFont, fontSize: 18.0, fontWeight: FontWeight.w700, ),),
            Container(
              height:height-itemHeight-titleHeight,
              padding:
                  const EdgeInsets.only(left: 10, top: 10, right: 20, bottom: 10),
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: videoItems.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, idx) {
                    final VideoItem item = videoItems[idx];
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => bloc.add(AnimationDetailVideoLoad(
                          detailItem: detailItem.copyWith(
                              selectVideoUrl: item.videoUrl))),
                      child: Container(
                        height: itemHeight,
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 50,
                                child: ImageItem(
                                  type: ImageShapeType.FLAT,
                                  imgRes: item.imageUrl,
                                )),
                            CustomText(
                              text: item.title,
                              fontColor: kWhite,
                              maxLines: 1,
                              isEllipsis: true,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.play_circle_fill,
                              color: kWhite,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Navigator.pop(context),
              child: Container(
                color: kWhite,
                height: itemHeight,
                alignment: Alignment.center,
                child: CustomText(
                  text: '나가기',
                  fontFamily: doHyunFont,
                ),
              ),
            )
          ],
      ),
    );
  }
}
