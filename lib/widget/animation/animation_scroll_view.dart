import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/animation_screen.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';
import 'package:kuma_flutter_app/widget/common/image_text_scroll_item.dart';
import 'package:kuma_flutter_app/widget/common/refresh_container.dart';
import 'package:kuma_flutter_app/widget/common/title_container.dart';
import 'package:kuma_flutter_app/widget/more/more_container.dart';
import 'package:kuma_flutter_app/screen/animation_schedule_screen.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_page_item.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/item/animation_schedule_item.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/bloc/animation_schedule/animation_schedule_bloc.dart';

import '../../bloc/animation_schedule/animation_schedule_bloc.dart';
import '../../widget/common/loading_indicator.dart';

class AnimationScrollView extends StatefulWidget {
  @override
  _AnimationScrollViewState createState() => _AnimationScrollViewState();
}

class _AnimationScrollViewState extends State<AnimationScrollView> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> scrollOffset = ValueNotifier<double>(0.0);

  @override
  Widget build(BuildContext context) {
    return OffsetListenableProvider(
      offset: scrollOffset,
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, isScrolled) {
          return [AnimationHomeSilverApp()];
        },
        body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            children: [
              _buildScheduleItems(context: context),
              _buildRankingItems(),
            ]),
      ),
    );
  }

  Widget _buildRankingItems() {
    return BlocBuilder<AnimationBloc, AnimationState>(
        builder: (context, state) {
          switch (state.status) {
            case BaseBlocStateStatus.Failure:
              return Container(
                height: 300,
                child: RefreshContainer(
                  callback: () =>
                      BlocProvider.of<AnimationBloc>(context).add(AnimationLoad()),
                ),
              );
            case BaseBlocStateStatus.Success:
              final List<AnimationMainItem> mainItemList = state.rankingList;
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
                  type: LoadingIndicatorType.IPhone,
                  isVisible: state.status == BaseBlocStateStatus.Loading ,
                ),
              );
          }
        });
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
                imageShapeType: ImageShapeType.Flat,
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
        List<AnimationScheduleItem> scheduleItems = state.scheduleItems;

        if (state.status ==  BaseBlocStateStatus.Failure) {
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
                  type: LoadingIndicatorType.IPhone,
                  isVisible: state.status ==  BaseBlocStateStatus.Loading,
                ))
          ],
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
                    imageShapeType: ImageShapeType.Flat,
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
      scrollOffset.value = _scrollController.offset;
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }
}

class OffsetListenableProvider extends InheritedWidget {
  final ValueListenable<double> offset;

  OffsetListenableProvider({Key key, @required this.offset, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ValueListenable<double> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OffsetListenableProvider>()
        .offset;
  }
}
