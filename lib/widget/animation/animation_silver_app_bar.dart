part of 'animation_widget.dart';

class AnimationHomeSilverAppBar extends StatefulWidget {
  @override
  _AnimationHomeSilverAppState createState() => _AnimationHomeSilverAppState();
}

class _AnimationHomeSilverAppState extends State<AnimationHomeSilverAppBar> {
  final AnimationMainAppbar animationMainAppbar = AnimationMainAppbar();
  double appbarOpacity = 0;
  Color appIconColors = kWhite;

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
                        return AnimationNotificationIcon(unReadCount:unReadCount, appIconColors: appIconColors,);
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
