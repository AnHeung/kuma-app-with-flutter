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

class AnimationDetailVideoLoad extends AnimationDetailEvent{

  final AnimationDetailItem detailItem;

  const AnimationDetailVideoLoad({this.detailItem});

  @override
  List<Object> get props =>[detailItem];
}


class AnimationDetailUpdate extends AnimationDetailEvent{

  final List<AnimationDetailItem> detailItem;

  const AnimationDetailUpdate({this.detailItem});

  @override
  List<Object> get props =>[detailItem];
}
