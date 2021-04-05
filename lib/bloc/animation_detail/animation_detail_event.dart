part of 'animation_detail_bloc.dart';

@immutable
abstract class AnimationDetailEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class AnimationDetailLoad extends AnimationDetailEvent{

  String id;

  AnimationDetailLoad({this.id});

  @override
  List<Object> get props =>[id];
}


class AnimationDetailUpdate extends AnimationDetailEvent{

  List<AnimationDetailItem> detailItem;

  AnimationDetailUpdate({this.detailItem});

  @override
  List<Object> get props =>[detailItem];
}
