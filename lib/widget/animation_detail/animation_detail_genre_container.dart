part of 'animation_detail_widget.dart';

class AnimationDetailGenreContainer extends StatelessWidget {

  final List<AnimationDetailGenreItem> genres;

  const AnimationDetailGenreContainer({this.genres});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 8 - 10;
    final List<AnimationDetailGenreItem> genreList = genres.length > 7 ? genres.sublist(0, 7) : genres;
    return !genreList.isNullOrEmpty && !genres.isNullOrEmpty
        ? Flexible(
        flex: 2,
        child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: genreList
                  .map((genre) => GestureDetector(
                onTap: _pushGenreSearchScreen(
                    context: context,
                    event: GenreClickFromDetailScreen(
                        navItem: GenreNavItem(
                            category: genre.name,
                            categoryValue: genre.id,
                            clickStatus: CategoryClickStatus.None,
                            genreType: GenreType.Genre))),
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kWhite.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: CustomText(
                      fontColor: kWhite,
                      fontSize: kAnimationDetailGenreFontSize,
                      text: genre.name,
                      isEllipsis: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ))
                  .toList(),
            )))
        : Container();
  }

  VoidCallback _pushGenreSearchScreen({BuildContext context, GenreClickFromDetailScreen event}) {
    return () {
      moveToHomeScreen(context: context);
      BlocProvider.of<TabCubit>(context).tabUpdate(AppTab.Genre);
      BlocProvider.of<GenreCategoryListBloc>(context).add(event);
    };
  }
}
