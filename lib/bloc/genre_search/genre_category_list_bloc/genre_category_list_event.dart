part of 'genre_category_list_bloc.dart';

@immutable
abstract class GenreCategoryListEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const GenreCategoryListEvent();

}

class GenreCategoryListLoad extends GenreCategoryListEvent{}

class GenreItemClick extends GenreCategoryListEvent{
  final GenreNavItem navItem;
  final List<GenreListItem> genreListItems;

  GenreItemClick({this.navItem, this.genreListItems});

  @override
  List<Object> get props =>[navItem , genreListItems];
}


class GenreItemRemove extends GenreCategoryListEvent{
  final GenreNavItem navItem;
  final List<GenreListItem> genreListItems;

  GenreItemRemove({this.navItem, this.genreListItems});

  @override
  List<Object> get props =>[navItem , genreListItems];
}