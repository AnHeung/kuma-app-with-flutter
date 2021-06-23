import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/bloc/notification/notification_bloc.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/animation/animation_main_appbar.dart';
import 'package:kuma_flutter_app/widget/animation/animation_scroll_view.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';


class AnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('AnimationScreen build');
    return Scaffold(
      extendBody: true,
      body: AnimationScrollView(),
    );
  }
}

class AnimationHomeSilverApp extends StatefulWidget {
  @override
  _AnimationHomeSilverAppState createState() => _AnimationHomeSilverAppState();
}

class _AnimationHomeSilverAppState extends State<AnimationHomeSilverApp> {
  final AnimationMainAppbar animationMainAppbar = AnimationMainAppbar();
  double appbarOpacity = 0;
  Color appIconColors = kWhite;

  Widget _notificationIcon({String unReadCount}){
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 30,
      height: 30,
      child: Stack(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            color: Colors.white,
            icon: Icon(
              Icons.notifications_none,
              color: appIconColors,
              size: 30,
            ),
            tooltip: "알림",
            onPressed: () {
              BlocProvider.of<NotificationBloc>(context)
                  .add(NotificationLoad());
              Navigator.pushNamed(
                  context, Routes.Notification);
            },
          ),
          Visibility(
              visible: unReadCount != "0",
              child:  Container(
                width: 30,
                height: 30,
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xffc32c37),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(unReadCount,
                        style: const TextStyle(fontSize: 7),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return ValueListenableBuilder(
          valueListenable: OffsetListenableProvider.of(context),
          builder: (context, value, child) {
            _changeAppbar(value);
            return SliverAppBar(
              backgroundColor: Colors.white,
              flexibleSpace: animationMainAppbar,
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
                    visible: state.status == AuthStatus.Auth,
                    child: BlocBuilder<NotificationBloc, NotificationState>(
                      builder: (context, state) {
                        String unReadCount = state.unReadCount;
                        return _notificationIcon(unReadCount:unReadCount);
                      },
                    )),
              ],
              // floating 설정. SliverAppBar는 스크롤 다운되면 화면 위로 사라짐.
              // true: 스크롤 업 하면 앱바가 바로 나타남. false: 리스트 최 상단에서 스크롤 업 할 때에만 앱바가 나타남
              floating: true,
              pinned: true,
              // flexibleSpace에 플레이스홀더를 추가
              // 최대 높이
              expandedHeight: kMainAppbarExpandedHeight,
            );
          });
    });
  }

  _changeAppbar(double scrollPosition) {
    if (scrollPosition == 0) {
      appbarOpacity = 0;
      appIconColors = kWhite;
    } else if (scrollPosition > 50 &&
        scrollPosition < 100 &&
        appbarOpacity != 0.5) {
      appbarOpacity = 0.5;
      appIconColors = Colors.black45;
    } else if (scrollPosition > 200 &&
        scrollPosition < 250 &&
        appbarOpacity != 0.7) {
      appbarOpacity = 0.7;
      appIconColors = Colors.black87;
    } else if (scrollPosition > 400 &&
        scrollPosition < 500 &&
        appbarOpacity != 1) {
      appbarOpacity = 1;
      appIconColors = kBlack;
    }
  }
}

