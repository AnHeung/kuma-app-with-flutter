part of 'genre_search_widget.dart';

class GenreGridView extends StatefulWidget {
  final Function(int) onLoadMore;
  final List<AnimationGenreSearchItem> genreSearchItems;
  final GenreData genreData;
  final int currentPage;

  GenreGridView({genreSearchItems, genreData ,this.onLoadMore ,currentPage})
      : this.genreSearchItems = genreSearchItems ?? [],
        this.genreData = genreData ?? GenreData(),
        this.currentPage = currentPage ?? kInitialPage;

  @override
  _GenreGridViewState createState() => _GenreGridViewState();
}

class _GenreGridViewState extends State<GenreGridView> {
  final int gridChildrenCount = 3;
  final double gridChildAspectRatio = 0.6;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.genreSearchItems.isNotEmpty
        ? Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: widget.genreSearchItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridChildrenCount,
            childAspectRatio: gridChildAspectRatio,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
          ),
          controller: _scrollController,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, idx) {
            final AnimationGenreSearchItem genreSearchItem =
            widget.genreSearchItems[idx];

            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, Routes.IMAGE_DETAIL,
                  arguments: AnimationDetailPageItem(
                      id: genreSearchItem.id,
                      title: genreSearchItem.title)),
              child: Container(
                  child: Column(
                    children: [
                      Expanded(
                          flex: 4,
                          child: ImageItem(
                            imgRes: genreSearchItem.image,
                            type: ImageShapeType.Flat,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                          flex: 1,
                          child: CustomText(
                            fontSize: 10.0,
                            text: genreSearchItem.title,
                            maxLines: 2,
                            fontWeight: FontWeight.w700,
                            isEllipsis: true,
                            textAlign: TextAlign.center,
                          ))
                    ],
                  )),
            );
          },
        ),
      ),
    )
        : const Expanded(
      child: EmptyContainer(
        title: "검색 목록 없음",
      ),
    );
  }

  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      widget.onLoadMore(widget.currentPage+1);
    }
  }
}