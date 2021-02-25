part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable{

  @override
  List<Object> get props =>[];
}

class SearchLoadInProgress extends SearchState {}

class SearchScreenClear extends SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadFailure extends SearchState {

  String errMsg;

  SearchLoadFailure({this.errMsg});

  @override
  List<Object> get props =>[];
}

class SearchHistoryLoadSuccess extends SearchState{

  List<AnimationSearchItem> list;


  SearchHistoryLoadSuccess({this.list});

  @override
  List<Object> get props =>[list];
}

class SearchItemLoadSuccess extends SearchState{

  List<AnimationSearchItem> list;


  SearchItemLoadSuccess({this.list});

  @override
  List<Object> get props =>[list];
}
