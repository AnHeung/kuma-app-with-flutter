part of 'animation_detail_bloc.dart';

@immutable
abstract class AnimationDetailEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const AnimationDetailEvent();
}

class AnimationDetailLoad extends AnimationDetailEvent{

  final String id;

  const AnimationDetailLoad({this.id});

  @override
  List<Object> get props =>[id];
}


class AnimationDetailUpdate extends AnimationDetailEvent{

  final List<AnimationDetailItem> detailItem;

  const AnimationDetailUpdate({this.detailItem});

  @override
  List<Object> get props =>[detailItem];
}
