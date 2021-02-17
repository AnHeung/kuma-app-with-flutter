part of 'animation_detail_bloc.dart';

@immutable
abstract class AnimationDetailState extends Equatable{
  @override
  List<Object> get props =>[];
}

class AnimationDetailLoadInProgress extends AnimationDetailState{}

class AnimationDetailLoadFailure extends AnimationDetailState{

  String errmsg;

  AnimationDetailLoadFailure({this.errmsg});

  @override
  List<Object> get props =>[errmsg];
}

class AnimationDetailLoadSuccess extends AnimationDetailState{

  AnimationDetailItem detailItem;

  AnimationDetailLoadSuccess({this.detailItem});

  @override
  List<Object> get props =>[detailItem];
}
