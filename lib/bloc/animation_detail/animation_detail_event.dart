part of 'animation_detail_bloc.dart';

@immutable
abstract class AnimationDetailEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class AnimationDetailLoad extends AnimationDetailEvent{

  String id;
  String type;

  AnimationDetailLoad({this.id, this.type});

  @override
  List<Object> get props =>[id, type];
}


class AnimationDetailUpdate extends AnimationDetailEvent{

  List<AnimationDetailItem> detailItem;

  AnimationDetailUpdate({this.detailItem});

  @override
  List<Object> get props =>[detailItem];
}
