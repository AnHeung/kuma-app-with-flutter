part of 'animation_detail_bloc.dart';

enum AnimationDetailStatus{ initial, loading , failure , success }

@immutable
class AnimationDetailState extends Equatable{

  final AnimationDetailStatus status;
  final AnimationDetailItem detailItem;
  final String msg;

  @override
  List<Object> get props =>[status, detailItem , msg];

  const AnimationDetailState({this.status = AnimationDetailStatus.initial, this.detailItem, this.msg = "상세페이지 에러"});
}
