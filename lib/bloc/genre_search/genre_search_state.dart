part of 'genre_search_bloc.dart';

@immutable
abstract class GenreSearchState extends Equatable{

  @override
  List<Object> get props =>[];
}

class GenreSearchInitial extends GenreSearchState {
  GenreSearchInitial({Map<String, CategoryClickStatus> clickMap});

}

class GenreSearchLoadInProgress extends GenreSearchState {
}

class GenreSearchLoadSuccess extends GenreSearchState {
  final List<AnimationGenreSearchItem> genreSearchItems;
  final GenreData genreData;

  GenreSearchLoadSuccess({this.genreSearchItems , clickMap ,this.genreData});

  @override
  List<Object> get props=>[genreSearchItems,genreData];
}

class GenreListLoadSuccess extends GenreSearchState {
  final List<GenreListItem> genreListItems;

  GenreListLoadSuccess({this.genreListItems});

  @override
  List<Object> get props =>[genreListItems];
}

class GenreSearchChangeView extends GenreSearchState {
  final List<String> categories;
  GenreSearchChangeView({this.categories});

  @override
  List<Object> get props =>[categories];
}

class GenreSearchLoadFailure extends GenreSearchState {
  final String errMSg;

  GenreSearchLoadFailure({this.errMSg});
}
class GenreListLoadFailure extends GenreSearchState {
  final String errMSg;

  GenreListLoadFailure({this.errMSg});

  @override
  List<Object> get props =>[errMSg];

}