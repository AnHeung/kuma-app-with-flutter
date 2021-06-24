part of 'genre_search_widget.dart';

class GenreCategoryItemContainer extends StatelessWidget {
  final List<GenreListItem> genreListItems;
  final GenreNavItem navItem;

  const GenreCategoryItemContainer({this.navItem, this.genreListItems});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        BlocProvider.of<GenreCategoryListBloc>(context)
            .add(GenreItemClick(navItem: navItem));
      },
      child: Container(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: CustomText(
                fontFamily: doHyunFont,
                text: navItem.category,
                fontColor:
                (navItem.clickStatus == CategoryClickStatus.Include ||
                    navItem.clickStatus == CategoryClickStatus.Exclude)
                    ? kPurple
                    : kBlack,
              ),
            ),
            const Spacer(),
            _buildCategoryIcon(navItem.clickStatus)
          ],
        ),
      ),
    );
  }

  _buildCategoryIcon(CategoryClickStatus status) {
    switch (status) {
      case CategoryClickStatus.Include:
        return const Icon(
          Icons.check_box_outlined,
          color: kPurple,
        );
      case CategoryClickStatus.Exclude:
        return const Icon(Icons.indeterminate_check_box_outlined, color: kPurple);
      case CategoryClickStatus.None:
        return const Icon(Icons.check_box_outline_blank);
    }
  }
}