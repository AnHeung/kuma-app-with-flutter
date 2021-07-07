part of 'more_widget.dart';

class MoreCategoryContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: separatorBuilder(context: context),
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
              case MoreType.Logout:
                showBaseDialog(
                    context: context,
                    title: kLogoutInfoTitle,
                    content: kMoreLogoutInfoMsg,
                    confirmFunction: () {
                      BlocProvider.of<AuthBloc>(context).add(SignOut());
                      Navigator.pop(context);
                    });
                break;
              case MoreType.VersionInfo:
                _showPackageInfo(context: context);
                break;
              case MoreType.Setting:
                Navigator.pushNamed(context, Routes.Setting);
                break;
            }
          },
          child: Container(
            height: kMoreContainerHeight,
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

  _showPackageInfo({BuildContext context}) {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      showOneBtnDialog(
        content: "앱이름: $appName\n\n 패키지명:$packageName\n\n version:$version\n\n buildNumber:$buildNumber",
        context: context,
        title: kMoreVersionInfoTitle,
      );
    });
  }
}
