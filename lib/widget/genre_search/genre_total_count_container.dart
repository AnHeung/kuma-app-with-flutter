part of 'genre_search_widget.dart';

class GenreSearchTotalCountContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreSearchBloc, GenreSearchState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: kBlack, width: 0.1))),
          alignment: Alignment.center,
          height: kGenreTopItemHeight,
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            child: CustomText(
                fontSize: 16.0,
                fontColor: Colors.black,
                text: "총 ${state.genreSearchItems.length ?? 0} 개의 작품이 검색됨.",
                fontFamily: doHyunFont),
          ),
        );
      },
    );
  }
}
