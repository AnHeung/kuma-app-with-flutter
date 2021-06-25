part of 'screen.dart';

class AnimationScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheduleLayoutWidth = MediaQuery.of(context).size.width * 0.25;
    final Color bgColor = Colors.blueGrey[50];

    return BlocBuilder<AnimationScheduleBloc, AnimationScheduleState>(
      builder: (context, state) {
        List<AnimationScheduleItem> scheduleItems = state.scheduleItems;
        String currentDay = state.currentDay ?? "1";
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            title: CustomText(
              text: kAnimationScheduleTitle,
              fontColor: kWhite,
              fontFamily: doHyunFont,
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      width: scheduleLayoutWidth,
                      child: AnimationScheduleIndicator(currentDay: currentDay),
                    ),
                    Expanded(child: AnimationScheduleContainer(items: scheduleItems),)
                  ],
                ),
              ),
              LoadingIndicator(isVisible: state.status == BaseBlocStateStatus.Loading,)
            ],
          ),
        );
      },
    );
  }
}
