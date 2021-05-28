part of 'genre_search_bloc.dart';

enum GenreSearchStatus { initial , success,  failure , loading }

@immutable
class GenreSearchState extends Equatable{

  final GenreSearchStatus status;
  final List<AnimationGenreSearchItem> genreSearchItems;
  final GenreData genreData;
  final int currentPage;
  final String msg;

  const GenreSearchState({this.status = GenreSearchStatus.initial , this.genreSearchItems = const <AnimationGenreSearchItem>[], this.genreData, this.msg, this.currentPage});

  @override
  List<Object> get props =>[status,genreSearchItems, genreData, msg, currentPage];
}
