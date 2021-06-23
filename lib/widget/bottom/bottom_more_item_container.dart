import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/bottom_more_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';
import 'package:kuma_flutter_app/widget/common/image_item.dart';

enum BottomMoreItemType { Character, Animation, Voice }

class BottomMoreItemContainer extends StatelessWidget {

  final String title;
  final List<BottomMoreItem> moreItems;
  final double itemHeight = 50;
  final BottomMoreItemType type;
  final double scrollItemHeight = 60;

  const BottomMoreItemContainer({this.moreItems, @required this.type , title}) : this.title = title ?? "더보기 목록";

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 50;
    const double titleHeight = 60;
    final double maxHeight = MediaQuery.of(context).size.height / 1.5;
    final height = moreItems.length * itemHeight > maxHeight ? maxHeight :  moreItems.length *itemHeight  + itemHeight *2 + titleHeight;

    return Container(
      color: kBlack,
      constraints: BoxConstraints(
          minHeight: itemHeight,
          minWidth: double.infinity,
          maxHeight:height),
      child: Column(
          children: [
            Container(padding: const EdgeInsets.only(top: 20, bottom: 10), height: titleHeight, child: CustomText(text: title, fontColor: kWhite,fontFamily: doHyunFont, fontSize: 18.0, fontWeight: FontWeight.w700, ),),
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
                  itemCount: moreItems.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, idx) {
                    final BottomMoreItem moreItem = moreItems[idx];

                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () =>_navigateScreen(context: context, item: moreItem),
                      child: Container(
                        height: scrollItemHeight,
                        child: Row(
                          children: [
                            Container(
                              child: ImageItem(
                                imgRes: moreItem.imgUrl,
                                type: ImageShapeType.Circle,
                              ),
                              height: itemHeight,
                              width: itemHeight,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: CustomText(text: moreItem.title, fontFamily: doHyunFont, fontSize: 15.0, fontColor: kWhite, maxLines: 2, isEllipsis: true,),
                              ),
                            )
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

  _navigateScreen({BuildContext context , BottomMoreItem item}){
    Navigator.pop(context);
    if(type == BottomMoreItemType.Character){
      Navigator.popUntil(context, ModalRoute.withName(Routes.IMAGE_DETAIL));
      showCharacterBottomSheet(context: context, id: item.id);
    }else if(type == BottomMoreItemType.Voice){
      showVoiceBottomSheet(context: context, id:item.id);
    }else if(type ==  BottomMoreItemType.Animation){
      moveToAnimationDetailScreen(context: context, id: item.id, title: item.title);
    }
  }
}
