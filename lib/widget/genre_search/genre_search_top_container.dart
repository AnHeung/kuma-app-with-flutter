part of 'genre_search_widget.dart';

class GenreSearchTopContainer extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const GenreSearchTopContainer({this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kGenreTopItemHeight,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          CustomText(
            fontFamily: doHyunFont,
            fontColor: kGrey,
            text: "선택된 필터",
            fontSize: 14.0,
          ),
          const Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: ()=>scaffoldKey.currentState.openEndDrawer(),
            child: Container(
                decoration:const  BoxDecoration(
                  color: kPurple,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                padding: const EdgeInsets.only(right: 10, left: 10),
                height: kGenreFilterItemHeight,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      fontWeight: FontWeight.w700,
                      text: "필터",
                      fontColor: kWhite,
                      fontSize: 10.0,
                    ),
                    const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
