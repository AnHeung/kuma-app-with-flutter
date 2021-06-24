part of 'animation_detail_bloc.dart';

class AnimationDetailState extends Equatable{

  final BaseBlocStateStatus status;
  final AnimationDetailItem detailItem;
  final String msg;

  @override
  List<Object> get props =>[status, detailItem , msg];

  const AnimationDetailState({this.status = BaseBlocStateStatus.Initial, this.detailItem, this.msg = "상세페이지 에러"});

  AnimationDetailState copyWith({
    BaseBlocStateStatus status,
    AnimationDetailItem detailItem,
    String msg,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (detailItem == null || identical(detailItem, this.detailItem)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return new AnimationDetailState(
      status: status ?? this.status,
      detailItem: detailItem ?? this.detailItem,
      msg: msg ?? this.msg,
    );
  }
}
