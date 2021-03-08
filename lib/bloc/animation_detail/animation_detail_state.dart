part of 'animation_detail_bloc.dart';

@immutable
abstract class AnimationDetailState extends Equatable{
  @override
  List<Object> get props =>[];

  const AnimationDetailState();

}

class AnimationDetailLoadInProgress extends AnimationDetailState{}

class AnimationDetailLoadFailure extends AnimationDetailState{

  final String errMsg;

  const AnimationDetailLoadFailure({this.errMsg});

  @override
  List<Object> get props =>[errMsg];
}

class AnimationDetailLoadSuccess extends AnimationDetailState{

  final AnimationDetailItem detailItem;

  const AnimationDetailLoadSuccess({this.detailItem});

  @override
  List<Object> get props =>[detailItem];
}
