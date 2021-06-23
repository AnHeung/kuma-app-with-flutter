part of 'animation_schedule_bloc.dart';

class AnimationScheduleState extends Equatable{

  final BaseBlocStateStatus status;
  final String currentDay;
  final List<AnimationScheduleItem> scheduleItems;
  final String msg;

  @override
  List<Object> get props =>[status, currentDay, scheduleItems ,msg];

  AnimationScheduleState copyWith({
    BaseBlocStateStatus status,
    String currentDay,
    List<AnimationScheduleItem> scheduleItems,
    String msg,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (currentDay == null || identical(currentDay, this.currentDay)) &&
        (scheduleItems == null ||
            identical(scheduleItems, this.scheduleItems)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return new AnimationScheduleState(
      status: status ?? this.status,
      currentDay: currentDay ?? this.currentDay,
      scheduleItems: scheduleItems ?? this.scheduleItems,
      msg: msg ?? this.msg,
    );
  }

  const AnimationScheduleState({this.status = BaseBlocStateStatus.Initial , this.currentDay = "1", this.scheduleItems = const <AnimationScheduleItem>[] ,this.msg = ""});

}
