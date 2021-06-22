part of 'genre_category_list_bloc.dart';

enum GenreCategoryStatus { Initial , Loading , Success, Failure }

@immutable
class GenreCategoryListState extends Equatable{

  final GenreCategoryStatus status;
  final List<GenreListItem> genreListItems;
  final GenreData genreData;
  final String msg;

  @override
  List<Object> get props =>[status , genreListItems , genreData , msg];

  const GenreCategoryListState({this.status, this.genreListItems, this.genreData, this.msg});

  GenreCategoryListState initialGenreCategoryState()=> GenreCategoryListState(status: GenreCategoryStatus.Initial , genreData: GenreData(), msg: "", genreListItems: []);

  GenreCategoryListState copyWith({
    GenreCategoryStatus status,
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