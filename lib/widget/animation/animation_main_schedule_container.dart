part of 'animation_widget.dart';

class AnimationMainScheduleContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            children: [
              const TitleContainer(fontWeight: FontWeight.w700, title: kAnimationScheduleTitle),
              const Spacer(),
              MoreContainer(
                onClick: () =>
                    navigateWithUpAnimation(
                        context: context,
                        navigateScreen: BlocProvider.value(
                          value: BlocProvider.of<AnimationScheduleBloc>(context)
                            ..add(AnimationScheduleLoad(day: "1")),
                          child: AnimationScheduleScreen(),
                        )),
              )
            ],
          ),
          AnimationMainScheduleItemContainer()
        ],
      ),
    );
  }
}
