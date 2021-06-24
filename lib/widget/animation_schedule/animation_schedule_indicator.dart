part of 'animation_schedule_widget.dart';

class AnimationScheduleIndicator extends StatelessWidget {

  final String currentDay;

  const AnimationScheduleIndicator({this.currentDay});

  @override
  Widget build(BuildContext context) {
    final double itemHeight = MediaQuery.of(context).size.height * 0.6 / 7;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: dayList.map((day) => GestureDetector(
        onTap: () {
          BlocProvider.of<AnimationScheduleBloc>(context)
              .add(AnimationScheduleLoad(day: day.getDayToNum()));
        },
        child: Container(
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: currentDay == day.getDayToNum() ? kLightBlue : kWhite,
            shape: BoxShape.circle,
          ),
          height: itemHeight,
          child: CustomText(
            isDynamic: true,
            text: day,
            fontColor: currentDay == day.getDayToNum() ? kWhite : kBlack,
            fontWeight: FontWeight.w700,
          ),
        ),
      ))
          .toList(),
    );
  }
}
