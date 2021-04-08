part of 'genre_category_list_bloc.dart';

@immutable
abstract class GenreCategoryListState extends Equatable{

  @override
  List<Object> get props =>[];

  const GenreCategoryListState();

}

class GenreCategoryListLoadInProgress extends GenreCategoryListState {}


class GenreListLoadSuccess extends GenreCategoryListState {
  final List<GenreListItem> genreListItems;
  final GenreData genreData;

  const GenreListLoadSuccess({this.genreListItems , this.genreData});

  @override
  List<Object> get props =>[genreListItems];
}

class GenreListLoadFailure extends GenreCategoryListState {
  final String errMSg;

  const GenreListLoadFailure({this.errMSg});

  @override
  List<Object> get props =>[errMSg];

}