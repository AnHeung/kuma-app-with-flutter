import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/animation_main_appbar.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/refresh_container.dart';

class AnimationScreen extends StatelessWidget {

  final AnimationMainAppbar animationMainAppbar = AnimationMainAppbar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              _buildSilverAppbar(animationMainAppbar)
            ];
          },
          body: BlocBuilder<AnimationBloc, AnimationState>(
              builder: (context, loadState) {
                switch(loadState.runtimeType){
                  case AnimationLoadFailure :
                    return RefreshContainer(
                      callback: () => BlocProvider.of<AnimationBloc>(context)
                          .add(AnimationLoad(
                          rankType: "all",
                          searchType: "all",
                          limit: "30")),
                    );
                  case AnimationLoadSuccess:
                    final List<AnimationMainItem> mainItemList =
                    (loadState is AnimationLoadSuccess)
                        ? loadState.rankingList
                        : [];

                    return Container(
                      child: ListView(
                            padding: EdgeInsets.zero,
                            children: mainItemList
                                .map((item) => _makeMainItem(context, item))
                                .toList(),
                          ),
                    );
                    break;
                  case AnimationLoadInProgress:
                    return LoadingIndicator(
                      isVisible: loadState is AnimationLoadInProgress,
                    );
                  default:
                    return EmptyContainer(title: "내용이 없습니다.",);
                }
              }),
        ),
      );
  }

  // Color _setItemColor(String type) {
  //   Color color = Colors.grey;
  //   switch (type) {
  //     case "airing":
  //       color = kLightBlue;
  //       break;
  //     case "movie":
  //       color = Colors.deepPurpleAccent[100];
  //       break;
  //     case "upcoming":
  //       color = Colors.pink[200];
  //       break;
  //     case "tv":
  //       color = Colors.deepPurpleAccent;
  //       break;
  //     case "ova":
  //       color = Colors.grey;
  //       break;
  //   }
  //   return color;
  // }

  Widget _buildSilverAppbar(Widget appbar){
    return  SliverAppBar(
      backgroundColor: Colors.white,
      flexibleSpace: appbar,
      centerTitle: true,
      title: CustomText(
        fontColor: Colors.black,
        fontWeight: FontWeight.w700,
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
      floating: true,
      pinned: true,
      // flexibleSpace에 플레이스홀더를 추가
      // 최대 높이
      expandedHeight: 450,
    );
  }

  Widget _makeMainItem(BuildContext context, final AnimationMainItem item) {
    double heightSize = (MediaQuery.of(context).size.height) * 0.4;

    return Container(
      height: heightSize,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:8 ,top: 20, bottom: 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: CustomText(text: item.koreaType, fontSize: 30, fontColor: kBlack,)),
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

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.IMAGE_DETAIL, arguments: item);
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
                margin: EdgeInsets.only( top: 10),
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
