part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable{

  @override
  List<Object> get props =>[];
}

class SearchLoadInProgress extends SearchState {}

class ClearSearchScreen extends SearchState {}

class InitialSearchScreen extends SearchState {}

class SetSearchScreen extends SearchState {}

class SearchLoadFailure extends SearchState {

  final String errMsg;

  SearchLoadFailure({this.errMsg});

  @override
  List<Object> get props =>[];
}

class SearchItemLoadSuccess extends SearchState{

  final List<AnimationSearchItem> list;

  SearchItemLoadSuccess({this.list});

  @override
  List<Object> get props =>[list];
}
