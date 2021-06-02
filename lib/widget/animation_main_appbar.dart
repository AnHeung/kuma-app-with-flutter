import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/animation_season/animation_season_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_season_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class AnimationMainAppbar extends StatefulWidget {

  @override
  _AnimationMainAppbarState createState() => _AnimationMainAppbarState();
}

class _AnimationMainAppbarState extends State<AnimationMainAppbar> {
  Timer timer;
  int currentPage = 0;
  VoidCallback pageControlListener ;
  PageController controller = PageController(initialPage: 0, keepPage: false);
  int totalPageCount = 0;
  int scrollTime = 3;


  @override
  void initState() {
    super.initState();
    pageControlListener = () {
      if(controller?.hasClients ?? false)currentPage = controller.page.ceil();
    };
  }

  _disposeJob(){
    print('_disposeJob');
    timer?.cancel();
    timer = null;
    controller?.removeListener(pageControlListener);
  }

  _resumeJob(){
    controller?.addListener(pageControlListener);
    timer = timer ?? Timer.periodic(Duration(seconds: scrollTime), (timer) {
      print("controller.hasClient ${controller.hasClients} currentPage : ${currentPage} totalPageCount: $totalPageCount ");
      if(controller.hasClients) {
        if (currentPage == totalPageCount) {
          controller?.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
          currentPage = 0;
        }else if (totalPageCount > 0) {
          controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimationSeasonBloc, AnimationSeasonState>(
      listenWhen: (prev,cur)=>cur is AnimationSeasonLoadFailure,
      listener: (context,state){
        String errMsg = (state is AnimationSeasonLoadFailure) ? state.errMsg : "에러발생";
        showToast(msg: errMsg);
      },
      builder: (context, seasonState) {
        if(seasonState is AnimationSeasonLoadSuccess) {
          List<AnimationSeasonItem> list = seasonState.seasonItems;
          totalPageCount = list.length <= 0 ? 0 : list.length - 1;
          bool isAutoScroll = seasonState.isAutoScroll;
          if(isAutoScroll)_disposeJob();
          return FocusDetector(
            onFocusGained: isAutoScroll?_resumeJob: null,
            onFocusLost: isAutoScroll? _disposeJob : null,
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
                    color: kWhite,
                    child: PageView(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      children: list
                          .map((data) =>
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(
                                    context, Routes.IMAGE_DETAIL,
                                    arguments: AnimationDetailPageItem(
                                        id: data.id.toString(), title: data.title)),
                            child: _pageViewContainer(data),
                          ))
                          .toList(),
                    ),
                  ),
                  _indicatorWidget(context: context, indicatorSize: list.length)
                ],
              ),
            ),
          );
        }else if(seasonState is AnimationSeasonLoadInProgress){
          return LoadingIndicator(isVisible: seasonState is AnimationSeasonLoadInProgress,);
        }else if(seasonState is AnimationSeasonLoadFailure){
          return RefreshContainer(callback: ()=>BlocProvider.of<AnimationSeasonBloc>(context).add(AnimationSeasonLoad(limit: "7")),);
        } else{
          return const EmptyContainer(title: '자료없음');

        }
      },
    );
  }

  Widget _pageViewContainer(AnimationSeasonItem item){

    return  Container(
      height: double.maxFinite,
      //// USE THIS FOR THE MATCH WIDTH AND HEIGHT
      width: double.maxFinite,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageItem(
            type: ImageShapeType.FLAT,
            imgRes: item.image,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 30 , left: 20),
            alignment: Alignment.bottomLeft,
            child: CustomText(
              fontColor: Colors.white,
              maxLines: 1,
              isEllipsis: true,
              fontFamily: doHyunFont,
              fontWeight: FontWeight.w700,
              fontSize:kAnimationTitleFontSize,
              text: item.title,
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicatorWidget({BuildContext context, int indicatorSize}){
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.1),
      alignment: Alignment.bottomCenter,
      child: Container(
        child: indicatorSize > 0
            ? SmoothPageIndicator(
          controller: controller,
          count: indicatorSize,
          effect: const WormEffect(dotWidth: 10, dotHeight: 10),
        )
            : const SizedBox(),
      ),
    );
  }
}
