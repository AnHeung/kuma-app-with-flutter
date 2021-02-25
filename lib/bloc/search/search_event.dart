part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class SearchUpdate extends SearchEvent{

  String searchQuery;

  SearchUpdate({this.searchQuery});

  @override
  List<Object> get props =>[searchQuery];
}

class SearchLoad extends SearchEvent{

  String searchQuery;

  SearchLoad({this.searchQuery});

  @override
  List<Object> get props =>[searchQuery];
}

class SearchClearHistory extends SearchEvent{}


class SearchHistoryLoad extends SearchEvent{}

class SearchHistoryWrite extends SearchEvent{

  AnimationSearchItem searchItem;

  SearchHistoryWrite({this.searchItem});

  @override
  List<Object> get props =>[searchItem];

}

class SearchClear extends SearchEvent{}
