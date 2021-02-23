part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable{

  @override
  List<Object> get props =>[];
}

class SearchLoadInProgress extends SearchState {}

class SearchInit extends SearchState {}

class SearchLoadFailure extends SearchState {

  String errMsg;

  SearchLoadFailure({this.errMsg});

  @override
  List<Object> get props =>[];
}

class SearchLoadSuccess extends SearchState{

  List<AnimationSearchItem> list;


  SearchLoadSuccess({this.list});

  @override
  List<Object> get props =>[list];
}

class SearchItemLoadSuccess extends SearchState{

  List<AnimationSearchItem> list;


  SearchItemLoadSuccess({this.list});

  @override
  List<Object> get props =>[list];
}
