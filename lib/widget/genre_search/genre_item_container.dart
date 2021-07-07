part of 'genre_search_widget.dart';

class GenreItemContainer extends StatefulWidget {
  final GenreListItem genreListItem;
  final List<GenreListItem> genreListItems;

  GenreItemContainer({this.genreListItem, this.genreListItems});

  @override
  _GenreItemsState createState() => _GenreItemsState();
}

class _GenreItemsState extends State<GenreItemContainer> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            height: kGenreItemContainerHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: CustomText(
                      text: widget.genreListItem.koreaType,
                      fontSize: 15.0,
                      fontFamily: doHyunFont,
                    ),
                  ),
                  const Spacer(),
                  isVisible
                      ? const Icon(Icons.arrow_drop_up_outlined)
                      : const Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          ),
          Visibility(
            visible: isVisible,
            child: Container(
              padding:const  EdgeInsets.only(left: 20, bottom: 10),
              child: Column(
                  children: widget.genreListItem.navItems.map((navItem) {
                    return GenreCategoryItemContainer(
                      navItem: navItem,
                      genreListItems: widget.genreListItems,
                    );
                  }).toList()),
            ),
          )
        ],
      ),
    );
  }
}