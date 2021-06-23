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

  GenreItemClick({this.navItem});

  @override
  List<Object> get props =>[navItem ];
}


class GenreItemRemove extends GenreCategoryListEvent{
  final GenreNavItem navItem;

  GenreItemRemove({this.navItem});

  @override
  List<Object> get props =>[navItem ];
}

class GenreItemRemoveAll extends GenreCategoryListEvent{}

class GenreClickFromDetailScreen extends GenreCategoryListEvent{
  final GenreNavItem navItem;

  GenreClickFromDetailScreen({this.navItem});

  @override
  List<Object> get props =>[navItem];
}
