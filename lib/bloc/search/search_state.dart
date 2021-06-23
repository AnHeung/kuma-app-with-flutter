part of 'search_bloc.dart';

enum SearchStatus { Loading , Initial , Clear ,Set, Failure ,Success}

@immutable
class SearchState extends Equatable{

  final SearchStatus status;
  final List<AnimationSearchItem> list;
  final String msg;

  const SearchState({this.status, this.list = const <AnimationSearchItem>[], this.msg});

  @override
  List<Object> get props =>[status,list, msg];

  SearchState copyWith({
    SearchStatus status,
    List<AnimationSearchItem> list,
    String msg,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (list == null || identical(list, this.list)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return new SearchState(
      status: status ?? this.status,
      list: list ?? this.list,
      msg: msg ?? this.msg,
    );
  }
}
