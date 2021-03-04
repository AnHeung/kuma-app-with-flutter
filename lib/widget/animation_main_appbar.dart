import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_season_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class AnimationMainAppbar extends StatelessWidget {

  Timer timer;
  int currentPage = 0;
  PageController controller;
  int totalPageCount = 0;
  int scrollTime = 3;

  AnimationMainAppbar(){
    controller = PageController(initialPage: currentPage)..addListener(() {
      if(controller.hasClients )currentPage = controller.page.ceil();
    });
    _resumeJob();
  }

  _disposeJob(){
    print('_disposeJob');
    timer?.cancel();
    timer = null;
  }

  _resumeJob(){
    print('resumeJob');
    timer = timer ?? Timer.periodic(Duration(seconds: scrollTime), (timer) {
      if(controller.hasClients) {
        if (currentPage == totalPageCount)
          controller?.jumpToPage(0);
        else if (totalPageCount > 0) {
          controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimationBloc, AnimationState>(
      buildWhen: (prev, cur){
        print("prev : $prev cur : $cur");
        return cur is AnimationSeasonLoadSuccess;
      },
      builder: (context, seasonState) {
        print('main Appbar State : $seasonState');
        List<AnimationSeasonItem> list = seasonState is AnimationSeasonLoadSuccess
            ? seasonState.seasonItems
            : List<AnimationSeasonItem>();
        totalPageCount = list.length <= 0 ? 0 : list.length - 1;

        return FocusDetector(
          onFocusGained: _resumeJob,
          onFocusLost: _disposeJob,
          child: FlexibleSpaceBar(
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: Colors.white,
                  child: PageView(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    children: list
                        .map((data) => GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, Routes.IMAGE_DETAIL,
                                  arguments: RankingItem(
                                      id: data.id, title: data.title)),
                              child: Container(
                                height: double.maxFinite,
                                //// USE THIS FOR THE MATCH WIDTH AND HEIGHT
                                width: double.maxFinite,
                                child: ImageItem(
                                  type: ImageShapeType.FLAT,
                                  imgRes: data.image,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.1),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: list.length > 0
                        ? SmoothPageIndicator(
                            controller: controller,
                            count: list.length,
                            effect: WormEffect(dotWidth: 10, dotHeight: 10),
                          )
                        : SizedBox(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
