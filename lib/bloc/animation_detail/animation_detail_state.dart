part of 'animation_detail_bloc.dart';

class AnimationDetailState extends Equatable{

  final BaseBlocStateStatus status;
  final AnimationDetailItem detailItem;
  final String msg;

  @override
  List<Object> get props =>[status, detailItem , msg];

  const AnimationDetailState({this.status = BaseBlocStateStatus.Initial, this.detailItem, this.msg = "상세페이지 에러"});
}
