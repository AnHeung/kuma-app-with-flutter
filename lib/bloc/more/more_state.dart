part of 'more_bloc.dart';

enum MoreStatus {Initial , Loading, Success , NeedLogin, Failure , }

class MoreState extends Equatable{

  final MoreStatus status;
  final String msg;

  const MoreState({this.status = MoreStatus.Initial,  this.msg = ""});

  @override
  List<Object> get props =>[status, msg];

}


