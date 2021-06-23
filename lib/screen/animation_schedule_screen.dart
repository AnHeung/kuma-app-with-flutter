import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/animation_schedule/animation_schedule_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_page_item.dart';
import 'package:kuma_flutter_app/model/item/animation_schedule_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';
import 'package:kuma_flutter_app/widget/common/image_item.dart';
import 'package:kuma_flutter_app/widget/common/loading_indicator.dart';

import 'package:kuma_flutter_app/util/common.dart';

class AnimationScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheduleLayoutWidth = MediaQuery.of(context).size.width * 0.25;
    final Color bgColor = Colors.blueGrey[50];

    return BlocBuilder<AnimationScheduleBloc, AnimationScheduleState>(
      builder: (context, state) {
        List<AnimationScheduleItem> scheduleItems = state.scheduleItems;
        String currentDay = state.currentDay ?? "1";
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            title: CustomText(
              text: kAnimationScheduleTitle,
              fontColor: kWhite,
              fontFamily: doHyunFont,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: scheduleLayoutWidth,
                  child: _buildScheduleIndicator(
                      context: context, currentDay: currentDay),
                ),
                Expanded(
                  child: _buildScheduleContainer(items: scheduleItems),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildScheduleContainer({List<AnimationScheduleItem> items}) {
    return items.isNotEmpty
        ? Container(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, idx) {
                final AnimationScheduleItem item = items[idx];
                return _buildScheduleItem(context:context, item: item);
              },
            ),
          )
        : const LoadingIndicator(
            isVisible: true,
          );
  }

  _buildScheduleItem({BuildContext context, AnimationScheduleItem item}) {
    double score = item.score != "null" ?  double.parse(item.score)/2 : 0;

    return GestureDetector(
      onTap: ()=>Navigator.pushNamed(context,Routes.IMAGE_DETAIL, arguments: AnimationDetailPageItem(id: item.id.toString(), title: item.title)),
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Container(
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                child: ImageItem(
                  imgRes: item.image,
                  type: ImageShapeType.Flat,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            text: item.title,
                            isEllipsis: true,
                            fontSize: 12.0,
                            fontFamily: doHyunFont,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          child: RatingBar(
                            rating: score,
                            icon:const Icon(Icons.star,size:20,color: Colors.white,),
                            starCount: 5,
                            spacing: 5.0,
                            size: 10,
                            isIndicator: false,
                            allowHalfRating: false,
                            onRatingCallback: (double value,ValueNotifier<bool> isIndicator){
                              print('Number of stars-->  $value');
                              //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                              isIndicator.value=true;
                            },
                            color: Colors.amber,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _buildScheduleIndicator({BuildContext context, String currentDay}) {
    final double itemHeight = MediaQuery.of(context).size.height * 0.6 / 7;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: dayList
          .map((day) => GestureDetector(
                onTap: () {
                  BlocProvider.of<AnimationScheduleBloc>(context)
                      .add(AnimationScheduleLoad(day: day.getDayToNum()));
                },
                child: Container(
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        currentDay == day.getDayToNum() ? kLightBlue : kWhite,
                    shape: BoxShape.circle,
                  ),
                  height: itemHeight,
                  child: CustomText(
                    isDynamic: true,
                    text: day,
                    fontColor: currentDay == day.getDayToNum() ? kWhite : kBlack,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
