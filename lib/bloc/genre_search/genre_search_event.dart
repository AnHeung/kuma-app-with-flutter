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

  @override
  List<Object> get props =>[data];
}


class GenreCategoryListLoad extends GenreSearchEvent{}


class GenreItemClick extends GenreSearchEvent{
  final GenreNavItem navItem;
  final List<GenreListItem> genreListItems;

  GenreItemClick({this.navItem, this.genreListItems});

  @override
  List<Object> get props =>[navItem , genreListItems];
}


class GenreItemRemove extends GenreSearchEvent{
  final GenreNavItem navItem;
  final List<GenreListItem> genreListItems;

  GenreItemRemove({this.navItem, this.genreListItems});

  @override
  List<Object> get props =>[navItem , genreListItems];
}
