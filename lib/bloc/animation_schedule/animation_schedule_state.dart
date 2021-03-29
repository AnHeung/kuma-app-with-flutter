part of 'animation_schedule_bloc.dart';

@immutable
abstract class AnimationScheduleState extends Equatable{

  @override
  List<Object> get props =>[];

  const AnimationScheduleState();

}

class AnimationScheduleLoadInProgress extends AnimationScheduleState {

}

class AnimationScheduleLoadSuccess extends AnimationScheduleState {
  final List<AnimationScheduleItem> scheduleItems;
  final String currentDay;

  const AnimationScheduleLoadSuccess({this.scheduleItems , this.currentDay});

  @override
  List<Object> get props =>[scheduleItems,currentDay];
}

class AnimationScheduleLoadFailure extends AnimationScheduleState {

  final String errMsg;

  const AnimationScheduleLoadFailure({this.errMsg});

  @override
  List<Object> get props =>[errMsg];
}

class AnimationScheduleChange extends AnimationScheduleState {

  final String day;

  const AnimationScheduleChange({this.day});

  @override
  List<Object> get props =>[day];
}
