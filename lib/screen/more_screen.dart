import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/enums/more_type.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:package_info/package_info.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final status = context.select((AuthBloc bloc) => bloc.state.status);
        if (status == AuthStatus.Auth) {
          return _moreContainer(context);
        }else if(status == AuthStatus.UnKnown) {
          return const LoadingIndicator(isVisible: true,);
        }else {
          return _needLoginContainer(context);
        }
      },
    );
  }

  Widget _moreContainer(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top + 20;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: '더보기',
                  fontSize: kMoreTitleFontSize,
                  fontWeight: FontWeight.w700,
                  fontColor: Colors.black,
                )),
            _topContainer()
          ],
        ),
      ),
    );
  }

  Widget _topContainer() {
    return ListView.separated(
      separatorBuilder: (context, idx) {
        return const SizedBox(
          height: 10,
        );
      },
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: MoreType.values.length,
      shrinkWrap: true,
      itemBuilder: (context, idx) {
        final IconData icon = MoreType.values[idx].icon;
        final String title = MoreType.values[idx].title;
        final MoreType type = MoreType.values[idx];
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            switch (type) {
              case MoreType.Account:
                Navigator.pushNamed(context, Routes.Account);
                break;
              case MoreType.Notification:
                Navigator.pushNamed(context, Routes.Notification);
                break;
              case MoreType.Logout:
                showBaseDialog(
                    context: context,
                    title: "로그아웃",
                    content: "로그아웃 하시겠습니까?",
                    confirmFunction: () {
                      BlocProvider.of<AuthBloc>(context).add(SignOut());
                      Navigator.pop(context);
                    });
                break;
              case MoreType.VersionInfo:
                PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
                  String appName = packageInfo.appName;
                  String packageName = packageInfo.packageName;
                  String version = packageInfo.version;
                  String buildNumber = packageInfo.buildNumber;
                  showOneBtnDialog(
                      content: " 앱이름: $appName\n\n 패키지명:$packageName\n\n version:$version\n\n buildNumber:$buildNumber",
                      context: context,
                      title: "버전정보",
                  );
                });
                break;
              case MoreType.Setting:
                Navigator.pushNamed(context, Routes.Setting);
                break;
            }
          },
          child: Container(
            height: 50,
            child: Row(
              children: [
                Icon(icon),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CustomText(
                    text: title,
                    fontColor: Colors.black,
                    fontSize: kMoreFontSize,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _needLoginContainer(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('로그인이 되어 있지 않습니다.'),
            Container(
              height: 30,
              margin: const EdgeInsets.only(top: 10),
              color: kBlue,
              child: TextButton(
                  onPressed: () => {Navigator.pushNamed(context, Routes.LOGIN)},
                  child: CustomText(
                    fontColor: kWhite,
                    fontFamily: doHyunFont,
                    text: "로그인/회원가입",
                    fontSize: kMoreLoginFontSize,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
