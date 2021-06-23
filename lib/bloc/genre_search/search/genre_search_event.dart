part of 'genre_search_bloc.dart';

@immutable
abstract class GenreSearchEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const GenreSearchEvent();

}

class GenreLoad extends GenreSearchEvent{

  final GenreData data;
  final String page;

  const GenreLoad({this.data,page}) : this.page = page ?? "1";

  @override
  List<Object> get props =>[data,page];
}


