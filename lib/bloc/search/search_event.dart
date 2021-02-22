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
