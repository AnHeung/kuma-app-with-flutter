part of 'animation_schedule_bloc.dart';

@immutable
abstract class AnimationScheduleEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const AnimationScheduleEvent();

}

class AnimationScheduleInitLoad extends AnimationScheduleEvent{}

class AnimationScheduleLoad extends AnimationScheduleEvent{

  final String day;

  AnimationScheduleLoad({this.day});

  @override
  List<Object> get props =>[day];
}

class AnimationScheduleClick extends AnimationScheduleEvent{

  final String day;

  AnimationScheduleClick({this.day});

  @override
  List<Object> get props =>[day];
}