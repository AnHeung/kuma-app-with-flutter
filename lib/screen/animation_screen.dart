import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_schedule/animation_schedule_bloc.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/item/animation_schedule_item.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/animation_schedule_screen.dart';
import 'package:kuma_flutter_app/util/navigator_util.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:kuma_flutter_app/widget/animation_main_appbar.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_text_scroll_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/more_container.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';
import 'package:kuma_flutter_app/widget/title_container.dart';

import '../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../util/string_util.dart';
import '../widget/loading_indicator.dart';

class AnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimationScrollView(),
    );
  }
}

class AnimationScrollView extends StatefulWidget {
  @override
  _AnimationScrollViewState createState() => _AnimationScrollViewState();
}

class _AnimationScrollViewState extends State<AnimationScrollView> {
  final AnimationMainAppbar animationMainAppbar = AnimationMainAppbar();
  final ScrollController _scrollController = ScrollController();

  double appbarOpacity = 0;
  Color appIconColors = kWhite;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, isScrolled) {
        return [_buildSilverAppbar(animationMainAppbar)];
      },
      body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          children: [
            _buildScheduleItems(context: context),
            _buildRankingItems(),
          ]),
    );
  }

  Widget _buildRankingItems() {
    return Container(
      child:
          BlocBuilder<AnimationBloc, AnimationState>(builder: (context, state) {
        switch (state.runtimeType) {
          case AnimationLoadFailure:
            return Container(
              height: 300,
              child: RefreshContainer(
                callback: () => BlocProvider.of<AnimationBloc>(context)
                    .add(AnimationLoad()),
              ),
            );
          case AnimationLoadSuccess:
            final List<AnimationMainItem> mainItemList =
                (state is AnimationLoadSuccess) ? state.rankingList : [];
            return ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: mainItemList
                  .map((item) => _buildRankingItem(context, item))
                  .toList(),
            );
          default:
            return Container(
              height: 300,
              child: LoadingIndicator(
                type: LoadingIndicatorType.IPHONE,
                isVisible: state is AnimationLoadInProgress,
              ),
            );
        }
      }),
    );
  }

  Widget _buildScheduleItems({BuildContext context}) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            children: [
              const TitleContainer(
                  fontWeight: FontWeight.w700, title: kAnimationScheduleTitle),
              const Spacer(),
              MoreContainer(
                onClick: () => navigateWithUpAnimation(
                    context: context,
                    navigateScreen: BlocProvider.value(
                      value: BlocProvider.of<AnimationScheduleBloc>(context)
                        ..add(AnimationScheduleLoad(day: "1")),
                      child: AnimationScheduleScreen(),
                    )),
              )
            ],
          ),
          _buildScheduleContainer()
        ],
      ),
    );
  }

  _buildScheduleIndicator(String currentDay) {
    final double itemWidth = MediaQuery.of(context).size.width / 7 - 4;
    return Container(
      height: 80,
      child: Row(
        children: dayList
            .map((day) => GestureDetector(
                  onTap: () => BlocProvider.of<AnimationScheduleBloc>(context)
                      .add(AnimationScheduleLoad(day: day.getDayToNum())),
                  child: Container(
                    width: itemWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: currentDay == day.getDayToNum()
                          ? kLightBlue
                          : kDisabled,
                      shape: BoxShape.circle,
                    ),
                    height: 40,
                    child: CustomText(
                      isDynamic: true,
                      text: day,
                      fontColor:
                          currentDay == day.getDayToNum() ? kWhite : kBlack,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  _buildScheduleBottomContainer(List<AnimationScheduleItem> scheduleItems) {
    return Container(
      height: 160,
      margin: const EdgeInsets.only(top: 10),
      child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: scheduleItems
              .map(
                (schedule) => ImageTextScrollItemContainer(
                    context: context,
                    imageShapeType: ImageShapeType.FLAT,
                    imageDiveRate: 4,
                    baseScrollItem: BaseScrollItem(
                      onTap: () => Navigator.pushNamed(
                          context, Routes.IMAGE_DETAIL,
                          arguments: AnimationDetailPageItem(
                              id: schedule.id, title: schedule.title)),
                      image: schedule.image,
                      id: schedule.id.toString(),
                      title: schedule.title,
                    )),
              )
              .toList()),
    );
  }

  _buildScheduleContainer() {
    return BlocBuilder<AnimationScheduleBloc, AnimationScheduleState>(
      builder: (context, state) {
        String currentDay = state.currentDay ?? "1";
        List<AnimationScheduleItem> scheduleItems =
            state is AnimationScheduleLoadSuccess ? state.scheduleItems : [];

        if (state is AnimationScheduleLoadFailure) {
          return Container(
              height: kAnimationScheduleContainerHeight,
              child: RefreshContainer(
                callback: () => BlocProvider.of<AnimationScheduleBloc>(context)
                    .add(AnimationScheduleLoad(day: "1")),
              ));
        }

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
            Container(
                height: kAnimationScheduleContainerHeight,
                child: LoadingIndicator(
                  type: LoadingIndicatorType.IPHONE,
                  isVisible: state is AnimationScheduleLoadInProgress,
                ))
          ],
        );
      },
    );
  }

  Widget _buildSilverAppbar(Widget appbar) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        bool isLogin = state.status == AuthStatus.Auth;

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
            Visibility(
              visible: isLogin,
              child: IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.notifications_none,
                  color: appIconColors,
                ),
                tooltip: "알림",
                onPressed: () => {print('알림')},
              ),
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
      },
    );
  }

  Widget _buildRankingItem(BuildContext context, final AnimationMainItem item) {
    double heightSize = (MediaQuery.of(context).size.height) *
        kAnimationRankingContainerHeightRate;

    return Container(
      height: heightSize,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TitleContainer(
                fontWeight: FontWeight.w700, title: item.koreaType),
          ),
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              children: item.list
                  .map(
                    (rankItem) => ImageTextScrollItemContainer(
                        imageShapeType: ImageShapeType.FLAT,
                        imageDiveRate: 3,
                        context: context,
                        baseScrollItem: BaseScrollItem(
                          title: rankItem.title,
                          id: rankItem.id.toString(),
                          image: rankItem.image,
                          score: rankItem.score,
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.IMAGE_DETAIL,
                            arguments: AnimationDetailPageItem(
                                id: rankItem.id, title: rankItem.title),
                          ),
                        )),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.hasClients) {
      _changeAppbar(_scrollController.offset);
    }
  }

  _changeAppbar(double scrollPosition) {
    if (scrollPosition == 0) {
      setState(() {
        appbarOpacity = 0;
        appIconColors = kWhite;
      });
    } else if (scrollPosition > 50 &&
        scrollPosition < 100 &&
        appbarOpacity != 0.5) {
      setState(() {
        appbarOpacity = 0.5;
        appIconColors = Colors.black45;
      });
    } else if (scrollPosition > 200 &&
        scrollPosition < 250 &&
        appbarOpacity != 0.7) {
      setState(() {
        appbarOpacity = 0.7;
        appIconColors = Colors.black87;
      });
    } else if (scrollPosition > 400 &&
        scrollPosition < 500 &&
        appbarOpacity != 1) {
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
}
