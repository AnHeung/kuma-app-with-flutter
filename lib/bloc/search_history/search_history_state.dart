part of 'search_history_bloc.dart';

class SearchHistoryState extends Equatable {

  final List<AnimationSearchItem> list;
  final BaseBlocStateStatus status;
  final String msg;

  @override
  List<Object> get props => [list,status, msg];

  SearchHistoryState copyWith({
    List<AnimationSearchItem> list,
    BaseBlocStateStatus status,
    String msg,
  }) {
    if ((list == null || identical(list, this.list)) &&
        (status == null || identical(status, this.status)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return SearchHistoryState(
      list: list ?? this.list,
      status: status ?? this.status,
      msg: msg ?? this.msg,
    );
  }

  const SearchHistoryState({this.list = const <AnimationSearchItem>[],this.status =BaseBlocStateStatus.Initial, this.msg =""});
}
