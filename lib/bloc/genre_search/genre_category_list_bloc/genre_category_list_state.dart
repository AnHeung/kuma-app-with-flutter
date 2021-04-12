part of 'genre_category_list_bloc.dart';

enum GenreCategoryStatus { initial , loading , success, failure }

@immutable
class GenreCategoryListState extends Equatable{

  final GenreCategoryStatus status;
  final List<GenreListItem> genreListItems;
  final GenreData genreData;
  final String msg;

  @override
  List<Object> get props =>[status , genreListItems , genreData , msg];

  const  GenreCategoryListState({this.status, this.genreListItems, this.genreData, this.msg});
}