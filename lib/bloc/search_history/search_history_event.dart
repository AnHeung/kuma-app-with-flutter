part of 'search_history_bloc.dart';

@immutable
abstract class SearchHistoryEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const SearchHistoryEvent();
}

class SearchHistoryClear extends SearchHistoryEvent{}

class SearchHistoryLoad extends SearchHistoryEvent{}

class SearchHistoryWrite extends SearchHistoryEvent{

  final AnimationSearchItem searchItem;

  const SearchHistoryWrite({this.searchItem});

  @override
  List<Object> get props =>[searchItem];

}
