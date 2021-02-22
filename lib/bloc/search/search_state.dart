part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable{

  @override
  List<Object> get props =>[];
}

class SearchLoadInProgress extends SearchState {}

class SearchLoadSuccess extends SearchState{

  List<AnimationSearchItem> list;
}
