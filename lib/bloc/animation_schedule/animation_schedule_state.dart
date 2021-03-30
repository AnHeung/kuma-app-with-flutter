part of 'animation_schedule_bloc.dart';

@immutable
abstract class AnimationScheduleState extends Equatable{

  final String currentDay;

  @override
  List<Object> get props =>[currentDay];

  const AnimationScheduleState({this.currentDay});

}

class AnimationScheduleLoadInProgress extends AnimationScheduleState {
  AnimationScheduleLoadInProgress({currentDay}):super(currentDay: currentDay);
}

class AnimationScheduleLoadSuccess extends AnimationScheduleState {
  final List<AnimationScheduleItem> scheduleItems;
  const AnimationScheduleLoadSuccess({this.scheduleItems , currentDay}) : super(currentDay: currentDay);

  @override
  List<Object> get props =>[scheduleItems,currentDay];
}

class AnimationScheduleLoadFailure extends AnimationScheduleState {

  final String errMsg;

  const AnimationScheduleLoadFailure({this.errMsg});

  @override
  List<Object> get props =>[errMsg];
}
