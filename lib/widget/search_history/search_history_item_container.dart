part of 'search_history_widget.dart';

class SearchHistoryItemContainer extends StatelessWidget {
  final List<AnimationSearchItem> list;

  const SearchHistoryItemContainer({this.list});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: list.isNotEmpty,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 3,
              scrollDirection: Axis.vertical,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              children: list
                  .map(
                    (historyItem) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        BlocProvider.of<SearchHistoryBloc>(context).add(
                            SearchHistoryWrite(
                                searchItem: AnimationSearchItem(
                                    id: historyItem.id,
                                    image: historyItem.image,
                                    title: historyItem.title)));
                        Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
                            arguments: AnimationDetailPageItem(
                                id: historyItem.id.toString(),
                                title: historyItem.title));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                           Container(
                              width: 100,
                              height: 100,
                              child: ImageItem(
                                type: ImageShapeType.Circle,
                                imgRes: historyItem.image,
                              ),
                            ),
                          Container(
                            alignment: Alignment.center,
                            width: 90,
                            height: 90,
                            child: CustomText(
                              fontFamily: doHyunFont,
                              fontSize: 10.0,
                              textAlign: TextAlign.center,
                              fontColor: kWhite,
                              text: historyItem.title,
                              maxLines: 2,
                              isEllipsis: true,
                              isDynamic: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList()),
        ));
  }
}
