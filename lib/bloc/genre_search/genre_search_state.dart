part of 'genre_search_bloc.dart';

@immutable
abstract class GenreSearchState extends Equatable{

  @override
  List<Object> get props =>[];

  const GenreSearchState();

}

class GenreSearchInitial extends GenreSearchState {}

class GenreSearchLoadInProgress extends GenreSearchState {}

class GenreSearchLoadSuccess extends GenreSearchState {

  final List<AnimationGenreSearchItem> genreSearchItems;
  final GenreData genreData;

  const GenreSearchLoadSuccess({this.genreSearchItems ,this.genreData});

  @override
  List<Object> get props=>[genreSearchItems,genreData];
}


class GenreSearchLoadFailure extends GenreSearchState {
  final String errMSg;

  const GenreSearchLoadFailure({this.errMSg});
}
