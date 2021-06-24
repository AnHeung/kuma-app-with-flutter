part of 'genre_search_widget.dart';

class GenreSearchGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreSearchBloc, GenreSearchState>(
      builder: (context, state) {
        List<AnimationGenreSearchItem> genreSearchItems = state.genreSearchItems;
        GenreData genreData = state.genreData;
        return GenreGridView(
          currentPage: state.currentPage,
          onLoadMore: (page)=>{
            BlocProvider.of<GenreSearchBloc>(context).add(GenreLoad(data: genreData ,page: page.toString()))
          },
          genreSearchItems: genreSearchItems,
          genreData: genreData,
        );
      },
    );
  }
}
