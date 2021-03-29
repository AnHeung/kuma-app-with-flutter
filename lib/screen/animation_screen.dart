import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_schedule/animation_schedule_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/item/animation_schedule_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:kuma_flutter_app/widget/animation_main_appbar.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';

import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../util/string_util.dart';
import '../widget/empty_container.dart';
import '../widget/loading_indicator.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  final AnimationMainAppbar animationMainAppbar = AnimationMainAppbar();
  final ScrollController _scrollController = ScrollController();
  final scrollbarExpandedHeight = 450;
  double appbarOpacity = 0;
  String currentDay = "1";
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
          _buildScheduleItems(),
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
            return RefreshContainer(
              callback: () =>
                  BlocProvider.of<AnimationBloc>(context).add(AnimationLoad()),
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
          case AnimationLoadInProgress:
            return Container(
              height: 300,
              child: LoadingIndicator(
                isVisible: loadState is AnimationLoadInProgress,
              ),
            );
          default:
            return EmptyContainer(
              title: "내용이 없습니다.",
            );
        }
      }),
    );
  }

  Widget _buildScheduleItems() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 18, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "요일별 신작",
                  fontFamily: doHyunFont,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
              Spacer(),
              Container(
                alignment: Alignment.center,
                child: CustomText(
                  text: "더보기 > ",
                  fontFamily: doHyunFont,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                  fontColor: Colors.grey,
                ),
              )
            ],
          ),
          _buildWeekendContainer()
        ],
      ),
    );
  }

  _buildWeekendIndicator() {
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
                            text: day,
                            fontColor: kWhite,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
  }

  _changeDayView(String day){
    setState(() {
      currentDay = day;
    });
  }

  _buildWeekendBottomContainer(){
    return BlocBuilder<AnimationScheduleBloc,AnimationScheduleState>(builder: (context,state){
      if(state is AnimationScheduleLoadSuccess){
        final List<AnimationScheduleItem> scheduleItems = state.scheduleItems;
        return Container(
          height: 150,
          margin: EdgeInsets.only(top: 10),
          child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              children: scheduleItems
                  .map((schedule) => _buildScheduleScrollItem(
                  context: context, item: schedule))
                  .toList()),
        );
      }
      return Container(height:150 ,child: LoadingIndicator(isVisible: state is AnimationScheduleLoadInProgress,));
    },);
  }

  _buildWeekendContainer() {
    return BlocListener<AnimationScheduleBloc , AnimationScheduleState>(
      listener: (context,state){
        if(state is AnimationScheduleChange){
          _changeDayView(state.day);
        }
      },
      child: Container(
        height: 260,
        child: Column(
          children: [
            _buildWeekendIndicator(),
            _buildWeekendBottomContainer()
          ],
        ),
      ),
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
          fontColor: Colors.black,
          fontWeight: FontWeight.w700,
          fontFamily: doHyunFont,
          text: "ANIMATION",
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
      expandedHeight: 450,
    );
  }

  Widget _buildRankingItem(BuildContext context, final AnimationMainItem item) {
    double heightSize = (MediaQuery.of(context).size.height) * 0.4;

    return Container(
      height: heightSize,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: CustomText(
                  text: item.koreaType,
                  fontSize: kAnimationItemTitleFontSize,
                  fontColor: kBlack,
                  fontFamily: nanumFont,
                )),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: item.list
                  .map((rankItem) => _buildRankScrollItem(context, rankItem))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleScrollItem(
      {BuildContext context, final AnimationScheduleItem item}) {
    final double width = MediaQuery.of(context).size.width / 4;
    final double height = 130;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
            arguments: AnimationDetailPageItem(
                id: item.id.toString(), title: item.title));
      },
      child: Container(
        padding: EdgeInsets.only(left: 8),
        width: width,
        height: height,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: ImageItem(
                  imgRes: item.image,
                  type: ImageShapeType.FLAT,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 5),
                child: CustomText(
                  fontWeight: FontWeight.w700,
                  fontColor: kBlack,
                  text: item.title,
                  maxLines: 2,
                  isDynamic: true,
                  isEllipsis: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRankScrollItem(BuildContext context, final RankingItem item) {
    double width = MediaQuery.of(context).size.width / 3;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
            arguments: AnimationDetailPageItem(
                id: item.id.toString(), title: item.title));
      },
      child: Container(
        padding: EdgeInsets.only(left: 8, bottom: 8),
        width: width,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: ImageItem(
                  imgRes: item.image,
                  type: ImageShapeType.FLAT,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 10),
                child: CustomText(
                  fontWeight: FontWeight.w700,
                  fontColor: kBlack,
                  text: item.title,
                  maxLines: 2,
                  isDynamic: true,
                  isEllipsis: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
