part of 'search_history_bloc.dart';

@immutable
abstract class SearchHistoryState extends Equatable {
  @override
  List<Object> get props => [];

  const SearchHistoryState();
}

class SearchHistoryInitial extends SearchHistoryState {}

class SearchHistoryLoadSuccess extends SearchHistoryState {
  final List<AnimationSearchItem> list;

  const SearchHistoryLoadSuccess({this.list});

  @override
  List<Object> get props => [list];
}
