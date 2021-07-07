part of 'screen.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SettingBloc>(context).add(SettingLoad());

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SettingBloc>(context).add(SettingScreenExit());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: kSettingAccountTitle,
            fontSize: 15.0,
            fontColor: kWhite,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocBuilder<SettingBloc, SettingState>(
                builder: (context, state) {
              SettingConfig config = state.config;
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SettingCategoryContainer(config: config),
                      SettingDropBoxContainer(config: config),
                      SettingCheckBoxContainer(
                          title: kSettingHomeAutoScrollTitle,
                          initialValue: config.isAutoScroll,
                          onToggle: (index) =>
                              BlocProvider.of<SettingBloc>(context).add(
                                  ChangeSetting(
                                      config: config.copyWith(
                                          isAutoScroll: index == 0)))),
                      SettingCheckBoxContainer(
                          title: kSettingNotificationTitle,
                          initialValue: config.receiveNotify,
                          onToggle: (index) =>
                              BlocProvider.of<SettingBloc>(context).add(
                                  ChangeSetting(
                                      config: config.copyWith(
                                          receiveNotify: index == 0)))),
                    ],
                  ),
                  LoadingIndicator(
                    type: LoadingIndicatorType.IPhone,
                    isVisible: state.status == SettingStatus.Loading,
                  )
                ],
              );
            })),
      ),
    );
  }
}
