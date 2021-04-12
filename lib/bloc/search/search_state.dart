part of 'search_bloc.dart';

enum SearchStatus { loading , initial , clear ,set, failure ,success}

@immutable
class SearchState extends Equatable{

  final SearchStatus status;
  final List<AnimationSearchItem> list;
  final String msg;

  SearchState({this.status, this.list, this.msg});

  @override
  List<Object> get props =>[status,list, msg];
}
