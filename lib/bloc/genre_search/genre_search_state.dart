part of 'genre_search_bloc.dart';

@immutable
abstract class GenreSearchState {}

class GenreSearchInitial extends GenreSearchState {}

class GenreSearchLoadInProgress extends GenreSearchState {}

class GenreSearchLoadSuccess extends GenreSearchState {
  final List<AnimationGenreSearchItem> genreSearchItems;
  GenreSearchLoadSuccess({this.genreSearchItems});
}

class GenreSearchChangeView extends GenreSearchState {
  final List<String> categories;
  GenreSearchChangeView({this.categories});
}

class GenreSearchLoadFailure extends GenreSearchState {
  final String errMSg;

  GenreSearchLoadFailure({this.errMSg});
}
