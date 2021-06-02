part of 'search_history_bloc.dart';

enum SearchHistoryStatus { Initial  , Loading ,  Failure, Success}

@immutable
class SearchHistoryState extends Equatable {

  final List<AnimationSearchItem> list;
  final SearchHistoryStatus status;
  final String msg;

  @override
  List<Object> get props => [list,status, msg];

  const SearchHistoryState({this.list,this.status, this.msg});
}
