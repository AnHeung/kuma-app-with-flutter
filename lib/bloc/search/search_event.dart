part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const SearchEvent();
}

class SearchQueryUpdate extends SearchEvent{

 final String searchQuery;

 SearchQueryUpdate({this.searchQuery});

  @override
  List<Object> get props =>[searchQuery];
}

class SearchLoad extends SearchEvent{

  final String searchQuery;

  const SearchLoad({this.searchQuery});

  @override
  List<Object> get props =>[searchQuery];
}


class SearchBtnClick extends SearchEvent{

  final bool isClick;

  SearchBtnClick({this.isClick});

}

class SearchClear extends SearchEvent{}
