import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/animation_main_appbar.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';

class AnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              flexibleSpace: AnimationMainAppbar(),
              centerTitle: true,
              title: CustomText(
                text: "메인",
                fontSize: 15,
              ),
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.notifications_none),
                  tooltip: "알림",
                  onPressed: () => {print('알림')},
                ),
              ],
              // floating 설정. SliverAppBar는 스크롤 다운되면 화면 위로 사라짐.
              // true: 스크롤 업 하면 앱바가 바로 나타남. false: 리스트 최 상단에서 스크롤 업 할 때에만 앱바가 나타남
              floating: false,
              snap: false,
              pinned: true,
              // flexibleSpace에 플레이스홀더를 추가
              // 최대 높이
              expandedHeight: 450,
            )
          ];
        },
        body: Stack(
          children: [
            BlocBuilder<AnimationBloc, AnimationState>(
                buildWhen: (prev, cur) => cur is AnimationLoadSuccess,
                builder: (context, state) {
                  print('init aniScreen');
                  final List<AnimationMainItem> mainItemList =
                      (state is AnimationLoadSuccess)
                          ? state.rankingList
                          : List();
                  return mainItemList.length > 0
                      ? ListView(
                          padding: EdgeInsets.zero,
                          children: mainItemList
                              .map((item) => _makeMainItem(context, item))
                              .toList(),
                        )
                      : RefreshContainer(
                          callback: () =>
                              BlocProvider.of<AnimationBloc>(context).add(
                                  AnimationLoad(
                                      rankType: "all",
                                      searchType: "all",
                                      limit: "30")),
                        );
                }),
            BlocBuilder<AnimationBloc, AnimationState>(
              builder: (context, state) => LoadingIndicator(
                isVisible: state is AnimationLoadInProgress,
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _setItemColor(String type) {
    Color color = Colors.grey;

    switch (type) {
      case "airing":
        color = Colors.cyan;
        break;
      case "movie":
        color = Colors.grey;
        break;
      case "upcoming":
        color = Colors.greenAccent;
        break;
    }
    return color;
  }

  Widget _makeMainItem(BuildContext context, final AnimationMainItem item) {
    double heightSize = (MediaQuery.of(context).size.height) * 0.40;

    return Container(
      height: heightSize,
      padding: EdgeInsets.all(10),
      color: _setItemColor(item.type),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: CustomText(text: item.type.toUpperCase(), fontSize: 20)),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: item.list
                  .map((rankItem) => _makeScrollItem(context, rankItem))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _makeScrollItem(BuildContext context, final RankingItem item) {
    double width = MediaQuery.of(context).size.width / 3;
    double heightSize = (MediaQuery.of(context).size.height) * 0.20;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.IMAGE_DETAIL, arguments: item);
      },
      child: Container(
        padding: EdgeInsets.only(left: 8, bottom: 8),
        height: heightSize,
        width: width,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 10),
                child: CustomText(
                  text: item.title,
                  maxLines: 2,
                  isDynamic: true,
                  isEllipsis: true,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: ImageItem(
                  imgRes: item.image,
                  type: ImageShapeType.FLAT,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
