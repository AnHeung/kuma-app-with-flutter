part of 'genre_search_bloc.dart';

@immutable
abstract class GenreSearchState extends Equatable{

  final Map<String,CategoryClickStatus> clickMap;

  const GenreSearchState({this.clickMap});

  @override
  List<Object> get props =>[clickMap];
}

class GenreSearchInitial extends GenreSearchState {
  GenreSearchInitial({Map<String, CategoryClickStatus> clickMap}) : super(clickMap: {});

}

class GenreSearchLoadInProgress extends GenreSearchState {
  GenreSearchLoadInProgress({Map<String, CategoryClickStatus> clickMap}) : super(clickMap: clickMap);
}

class GenreSearchLoadSuccess extends GenreSearchState {
  final List<AnimationGenreSearchItem> genreSearchItems;
  final GenreData genreData;

  GenreSearchLoadSuccess({this.genreSearchItems , clickMap ,this.genreData}) : super(clickMap: clickMap);
}

class GenreSearchChangeView extends GenreSearchState {
  final List<String> categories;
  GenreSearchChangeView({this.categories}) : super(clickMap: {});
}

class GenreSearchLoadFailure extends GenreSearchState {
  final String errMSg;

  GenreSearchLoadFailure({this.errMSg,Map<String, CategoryClickStatus> clickMap}) : super(clickMap:clickMap);
}
