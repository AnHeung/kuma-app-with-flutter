part of 'more_bloc.dart';

@immutable
abstract class MoreEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const MoreEvent();
}

class MakeAuthScreen extends MoreEvent{}

class MakeUnAuthScreen extends MoreEvent{}


