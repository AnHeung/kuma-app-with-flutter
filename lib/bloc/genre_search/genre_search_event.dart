part of 'genre_search_bloc.dart';

@immutable
abstract class GenreSearchEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const GenreSearchEvent();

}

class GenreLoad extends GenreSearchEvent{

  final GenreData data;

  const GenreLoad({this.data});
}

class GenreItemClick extends GenreSearchEvent{
  final List<String> clickItems;
  final List<AnimationGenreSearchItem> genreSearchItems;

  GenreItemClick({this.clickItems, this.genreSearchItems});
}
