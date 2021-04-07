import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_schedule/animation_schedule_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/item/animation_schedule_item.dart';
import 'package:kuma_flutter_app/screen/animation_schedule_screen.dart';
import 'package:kuma_flutter_app/util/navigator_util.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:kuma_flutter_app/widget/animation_main_appbar.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_text_scroll_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';

import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../util/string_util.dart';
import '../widget/loading_indicator.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  final AnimationMainAppbar animationMainAppbar = AnimationMainAppbar();
  final ScrollController _scrollController = ScrollController();
  double appbarOpacity = 0;
  Color appIconColors = kWhite;
  VoidCallback _scrollListener;

  _AnimationScreenState() {
    _scrollListener = () {
      if (_scrollController.hasClients) {
        _changeAppbar(_scrollController.offset);
      }
    };
    _scrollController.addListener(_scrollListener);
  }

  _changeAppbar(double scrollPosition) {
    if (scrollPosition == 0) {
      setState(() {
        appbarOpacity = 0;
        appIconColors = kWhite;
      });
    } else if (scrollPosition > 50 && scrollPosition < 100) {
      setState(() {
        appbarOpacity = 0.5;
        appIconColors = Colors.black45;
      });
    } else if (scrollPosition > 200 && scrollPosition < 250) {
      setState(() {
        appbarOpacity = 0.7;
        appIconColors = Colors.black87;
      });
    } else if (scrollPosition > 400 && scrollPosition < 500) {
      setState(() {
        appbarOpacity = 1;
        appIconColors = kBlack;
      });
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, isScrolled) {
          return [_buildSilverAppbar(animationMainAppbar)];
        },
        body: ListView(shrinkWrap: true, padding: EdgeInsets.zero, children: [
          _buildScheduleItems(context: context),
          _buildRankingItems(),
        ]),
      ),
    );
  }

  Widget _buildRankingItems() {
    return Container(
      child: BlocBuilder<AnimationBloc, AnimationState>(
          builder: (context, loadState) {
        switch (loadState.runtimeType) {
          case AnimationLoadFailure:
            return Container(
              height: 300,
              child: RefreshContainer(
                callback: () =>
                    BlocProvider.of<AnimationBloc>(context).add(AnimationLoad()),
              ),
            );
          case AnimationLoadSuccess:
            final List<AnimationMainItem> mainItemList =
                (loadState is AnimationLoadSuccess)
                    ? loadState.rankingList
                    : [];
            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: mainItemList
                  .map((item) => _buildRankingItem(context, item))
                  .toList(),
            );
            break;
          default:
            return Container(
              height: 300,
              child: LoadingIndicator(
                isVisible: loadState is AnimationLoadInProgress,
              ),
            );
        }
      }),
    );
  }

  Widget _buildTitleContainer({String title}){
    return Container(
      alignment: Alignment.centerLeft,
      child: CustomText(
        text: title,
        fontFamily: doHyunFont,
        fontWeight: FontWeight.w700,
        fontSize: kAnimationItemTitleFontSize,
      ),
    );
  }

  Widget _buildScheduleItems({BuildContext context}) {

    return Container(
      padding: EdgeInsets.only(top: 20, left: 18, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              _buildTitleContainer(title: kAnimationScheduleTitle),
              Spacer(),
              GestureDetector(
                onTap: ()=>navigateWithUpAnimation(context: context , navigateScreen: BlocProvider.value(value: BlocProvider.of<AnimationScheduleBloc>(context)..add(AnimationScheduleLoad(day: "1")), child: AnimationScheduleScreen(),)),
                behavior: HitTestBehavior.translucent,
                child: Container(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: "더보기 > ",
                    fontFamily: doHyunFont,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                    fontColor: Colors.grey,
                  ),
                ),
              )
            ],
          ),
          _buildScheduleContainer()
        ],
      ),
    );
  }

  _buildScheduleIndicator(String currentDay) {
    final double itemWidth = MediaQuery.of(context).size.width / 7 - 6;
    return Container(
            height: 80,
            child: Row(
              children: dayList
                  .map((day) => GestureDetector(
                        onTap: () =>
                            BlocProvider.of<AnimationScheduleBloc>(context).add(
                                AnimationScheduleLoad(day: getDayToNum(day))),
                        child: Container(
                          width: itemWidth,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: currentDay == getDayToNum(day) ? kLightBlue : kDisabled,
                            shape: BoxShape.circle,
                          ),
                          height: 40,
                          child: CustomText(
                            isDynamic: true,
                            text: day,
                            fontColor: currentDay == getDayToNum(day) ? kWhite : kBlack,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
  }

  _buildScheduleBottomContainer(List<AnimationScheduleItem>  scheduleItems){
      return Container(
        height: 160,
        margin: EdgeInsets.only(top: 10),
        child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            children: scheduleItems
                .map((schedule) =>
                ImageTextScrollItem(context: context,
                  image: schedule.image,
                  id: schedule.id.toString(),
                  title: schedule.title,
                  imageDiveRate: 4,))
                .toList()),
      );
  }

  _buildScheduleContainer() {
    return BlocBuilder<AnimationScheduleBloc , AnimationScheduleState>(
      builder: (context, state){
        String currentDay =  state.currentDay ??  "1";
        List<AnimationScheduleItem> scheduleItems = state is AnimationScheduleLoadSuccess ? state.scheduleItems :[] ;
        print("scheduleItems : $scheduleItems");

        return Stack(
          children: [
            Container(
              height: kAnimationScheduleContainerHeight,
              child: Column(
                children: [
                  _buildScheduleIndicator(currentDay),
                  _buildScheduleBottomContainer(scheduleItems)
                ],
              ),
            ),
            Container(height : kAnimationScheduleContainerHeight ,child: LoadingIndicator(isVisible: state is AnimationScheduleLoadInProgress,))
          ],
        );
      },
    );
  }

  Widget _buildSilverAppbar(Widget appbar) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      flexibleSpace: appbar,
      centerTitle: true,
      title: Opacity(
        opacity: appbarOpacity,
        child: CustomText(
          fontWeight: FontWeight.w700,
          fontFamily: doHyunFont,
          text: kAnimationAppbarTitle,
          fontSize: kAnimationTitleFontSize,
        ),
      ),
      actions: <Widget>[
        IconButton(
          color: Colors.white,
          icon: Icon(
            Icons.notifications_none,
            color: appIconColors,
          ),
          tooltip: "알림",
          onPressed: () => {print('알림')},
        ),
      ],
      // floating 설정. SliverAppBar는 스크롤 다운되면 화면 위로 사라짐.
      // true: 스크롤 업 하면 앱바가 바로 나타남. false: 리스트 최 상단에서 스크롤 업 할 때에만 앱바가 나타남
      floating: true,
      pinned: true,
      // flexibleSpace에 플레이스홀더를 추가
      // 최대 높이
      expandedHeight: kMainAppbarExpandedHeight,
    );
  }

  Widget _buildRankingItem(BuildContext context, final AnimationMainItem item) {
    double heightSize = (MediaQuery.of(context).size.height) * kAnimationRankingContainerHeightRate;

    return Container(
      height: heightSize,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 10),
            child: _buildTitleContainer(title: item.koreaType),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: item.list
                  .map((rankItem) => ImageTextScrollItem(context: context ,title: rankItem.title , id: rankItem.id.toString(), image: rankItem.image,imageShapeType: ImageShapeType.FLAT,imageDiveRate: 3, ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
