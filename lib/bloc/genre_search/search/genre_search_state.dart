part of 'genre_search_bloc.dart';

class GenreSearchState extends Equatable{

  final BaseBlocStateStatus status;
  final List<AnimationGenreSearchItem> genreSearchItems;
  final GenreData genreData;
  final int currentPage;
  final String msg;

  const GenreSearchState({this.status = BaseBlocStateStatus.Initial , this.genreSearchItems = const <AnimationGenreSearchItem>[], this.genreData, this.msg="", this.currentPage = 1});

  GenreSearchState copyWith({
    BaseBlocStateStatus status,
    List<AnimationGenreSearchItem> genreSearchItems,
    GenreData genreData,
    int currentPage,
    String msg,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (genreSearchItems == null ||
            identical(genreSearchItems, this.genreSearchItems)) &&
        (genreData == null || identical(genreData, this.genreData)) &&
        (currentPage == null || identical(currentPage, this.currentPage)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return GenreSearchState(
      status: status ?? this.status,
      genreSearchItems: genreSearchItems ?? this.genreSearchItems,
      genreData: genreData ?? this.genreData,
      currentPage: currentPage ?? this.currentPage,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object> get props =>[status,genreSearchItems, genreData, msg, currentPage];
}
