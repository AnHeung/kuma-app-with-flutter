part of 'animation_widget.dart';

class AnimationMainScheduleItemContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  AnimationMainScheduleIndicator(currentDay: currentDay),
                  AnimationMainScheduleBottomContainer(scheduleItems: scheduleItems)
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
}
