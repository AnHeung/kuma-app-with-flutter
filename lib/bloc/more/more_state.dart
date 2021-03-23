part of 'more_bloc.dart';

@immutable
abstract class MoreState extends Equatable{

  const MoreState();

  @override
  List<Object> get props =>[];

}

class MoreInitial extends MoreState {}

class MoreLoadingInProgress extends MoreState {}

class MoreLoadSuccess extends MoreState {}

class MoreNeedLogin extends MoreState {}

class MoreLoadFailure extends MoreState {

  final String errMsg;

  const MoreLoadFailure({this.errMsg});

  @override
  List<Object> get props =>[errMsg];
}


