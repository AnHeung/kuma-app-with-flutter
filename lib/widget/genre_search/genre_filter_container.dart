part of 'genre_search_widget.dart';

class GenreSearchFilterContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<GenreNavItem> genreClickItems = [];

    return BlocBuilder<GenreCategoryListBloc, GenreCategoryListState>(
      builder: (context, state) {
        if (state.status == BaseBlocStateStatus.Success) {
          genreClickItems = state.genreListItems.fold([], (acc, genreItem) {
            genreItem.navItems
                .where((navItem) => navItem.clickStatus != CategoryClickStatus.None)
                .forEach((item) => acc.add(item));
            return acc;
          });
        }
        return Visibility(
          visible: genreClickItems.isNotEmpty,
          child: Container(
            height: kGenreTopItemHeight,
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: kBlack, width: 0.1),
                    bottom: BorderSide(color: kBlack, width: 0.1))),
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.check_box_outlined,
                  color: kPurple,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 25,
                    child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, idx) {
                        final GenreNavItem item = genreClickItems[idx];
                        return GestureDetector(
                          onTap: () => BlocProvider.of<GenreCategoryListBloc>(context)
                                  .add(GenreItemRemove(navItem: item)),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 4, bottom: 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    width: 0.5, color: kBlack)),
                            child: Row(
                              children: [
                                CustomText(
                                  fontFamily: doHyunFont,
                                  text: item.category,
                                  fontSize: 12.0,
                                  fontColor: kGrey,
                                ),
                                const Icon(
                                  Icons.close,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: separatorBuilder(context: context ,size: 7),
                      itemCount: genreClickItems.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
