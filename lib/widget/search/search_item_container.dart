part of 'search_widget.dart';

class SearchItemContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context , state){
        if(state.status == SearchStatus.Failure) showToast(msg: state.msg);
      },
      builder: (context, state) {
        List<AnimationSearchItem> list = state.list;
        return Visibility(
          visible: list.isNotEmpty,
          child: Container(
            constraints: BoxConstraints(
                minHeight: kSearchItemContainerMinHeight,
                minWidth: double.infinity,
                maxHeight: MediaQuery.of(context).size.height * kSearchItemContainerMaxHeightRate),
            color: kBlack,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: list
                  .map((searchItem) => SearchImageItemContainer(
                imgRes: searchItem.image,
                title: searchItem.title,
                onTap: () {
                  BlocProvider.of<SearchHistoryBloc>(context).add(SearchHistoryWrite(searchItem: AnimationSearchItem(id: searchItem.id, image: searchItem.image, title: searchItem.title)));
                  Navigator.pushNamed(context, Routes.IMAGE_DETAIL, arguments: AnimationDetailPageItem(id: searchItem.id.toString(), title: searchItem.title));
                },
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
