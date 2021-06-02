part of 'search_bloc.dart';

enum SearchStatus { Loading , Initial , Clear ,Set, Failure ,Success}

@immutable
class SearchState extends Equatable{

  final SearchStatus status;
  final List<AnimationSearchItem> list;
  final String msg;

  SearchState({this.status, List<AnimationSearchItem> list, this.msg}) : this.list =  list ?? [];

  @override
  List<Object> get props =>[status,list, msg];
}
