part of 'search_history_bloc.dart';

@immutable
abstract class SearchHistoryState {}

class SearchHistoryInitial extends SearchHistoryState {}

class SearchHistoryLoadSuccess extends SearchHistoryState{

  final List<AnimationSearchItem> list;


  SearchHistoryLoadSuccess({this.list});

  @override
  List<Object> get props =>[list];
}