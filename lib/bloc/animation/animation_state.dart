part of 'animation_bloc.dart';

class AnimationState extends Equatable{

  final BaseBlocStateStatus status;
  final List<AnimationMainItem> rankingList;
  final String msg;

  const AnimationState({this.status = BaseBlocStateStatus.Initial, this.rankingList = const <AnimationMainItem>[], this.msg = ""});

  AnimationState copyWith({
    BaseBlocStateStatus status,
    List<AnimationMainItem> rankingList,
    String msg,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (rankingList == null || identical(rankingList, this.rankingList)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return new AnimationState(
      status: status ?? this.status,
      rankingList: rankingList ?? this.rankingList,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object> get props => [status , rankingList, msg];
}
