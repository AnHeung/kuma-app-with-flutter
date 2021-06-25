part of 'search_history_widget.dart';

class SearchHistoryContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchHistoryBloc, SearchHistoryState>(
      listener: (context,state){
        if(state.status == SearchStatus.Failure) showToast(msg: state.msg);
      },
      builder: (context, state) {
        List<AnimationSearchItem> searchHistoryList = state.list;
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: InnerTextGridContainer(
                imageShapeType: ImageShapeType.Circle,
                gridCount: 3,
                list: searchHistoryList
                    .map((item) => BaseScrollItem(
                    id: item.id,
                    title: item.title,
                    image: item.image,
                    onTap: () {
                      BlocProvider.of<SearchHistoryBloc>(context).add(
                          SearchHistoryWrite(
                              searchItem: AnimationSearchItem(
                                  id: item.id,
                                  image: item.image,
                                  title: item.title)));
                      Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
                          arguments: AnimationDetailPageItem(
                              id: item.id.toString(), title: item.title));
                    }))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
