part of 'genre_category_list_bloc.dart';

class GenreCategoryListState extends Equatable{

  final BaseBlocStateStatus status;
  final List<GenreListItem> genreListItems;
  final GenreData genreData;
  final String msg;

  @override
  List<Object> get props =>[status , genreListItems , genreData , msg];

  const GenreCategoryListState({this.status, this.genreListItems, this.genreData, this.msg});

  GenreCategoryListState copyWith({
    BaseBlocStateStatus status,
    List<GenreListItem> genreListItems,
    GenreData genreData,
    String msg,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (genreListItems == null ||
            identical(genreListItems, this.genreListItems)) &&
        (genreData == null || identical(genreData, this.genreData)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return GenreCategoryListState(
      status: status ?? this.status,
      genreListItems: genreListItems ?? this.genreListItems,
      genreData: genreData ?? this.genreData,
      msg: msg ?? this.msg,
    );
  }
}