part of 'more_bloc.dart';

@immutable
abstract class MoreState extends Equatable{

  const MoreState();

  @override
  List<Object> get props =>[];

}

class MoreInitial extends MoreState {}

class MoreLoadSuccess extends MoreState {}

class MoreLoadingInProgress extends MoreState {}


