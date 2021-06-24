part of 'animation_widget.dart';

class AnimationMainScheduleIndicator extends StatelessWidget {

  final String currentDay;

  const AnimationMainScheduleIndicator({this.currentDay});

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width / 7 - 4;
    return Container(
      height: 80,
      child: Row(
        children: dayList
            .map((day) => GestureDetector(
          onTap: () => BlocProvider.of<AnimationScheduleBloc>(context)
              .add(AnimationScheduleLoad(day: day.getDayToNum())),
          child: Container(
            width: itemWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: currentDay == day.getDayToNum()
                  ? kLightBlue
                  : kDisabled,
              shape: BoxShape.circle,
            ),
            height: 40,
            child: CustomText(
              isDynamic: true,
              text: day,
              fontColor:
              currentDay == day.getDayToNum() ? kWhite : kBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
        ))
            .toList(),
      ),
    );
  }
}
