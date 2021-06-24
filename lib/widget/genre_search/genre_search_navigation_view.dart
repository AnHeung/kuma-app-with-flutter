part of 'genre_search_widget.dart';

class GenreSearchNavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GenreCategoryListBloc, GenreCategoryListState>(
      builder: (context, state) {
        List<GenreListItem> genreListItems = state.genreListItems;

        return SafeArea(
          child: Drawer(
            child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: genreListItems
                    .map((item) => GenreItemContainer(
                    genreListItem: item, genreListItems: genreListItems))
                    .toList()),
          ),
        );
      },
    );
  }
}
