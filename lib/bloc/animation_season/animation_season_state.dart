part of 'animation_season_bloc.dart';

enum AnimationSeasonStatus {Initial, Loading,  Success, Failure ,}

class AnimationSeasonState extends Equatable{

  final AnimationSeasonStatus status;
  final List<AnimationSeasonItem> seasonItems;
  final String msg;
  final bool isAutoScroll;

  const AnimationSeasonState({this.status = AnimationSeasonStatus.Initial , this.isAutoScroll = true, this.msg="" , this.seasonItems = const<AnimationSeasonItem>[]});

  AnimationSeasonState copyWith({
    AnimationSeasonStatus status,
    List<AnimationSeasonItem> seasonItems,
    String msg,
    bool isAutoScroll,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (seasonItems == null || identical(seasonItems, this.seasonItems)) &&
        (msg == null || identical(msg, this.msg)) &&
        (isAutoScroll == null || identical(isAutoScroll, this.isAutoScroll))) {
      return this;
    }

    return  AnimationSeasonState(
      status: status ?? this.status,
      seasonItems: seasonItems ?? this.seasonItems,
      msg: msg ?? this.msg,
      isAutoScroll: isAutoScroll ?? this.isAutoScroll,
    );
  }

  @override
  List<Object> get props =>[status, seasonItems , msg,  isAutoScroll];

}
