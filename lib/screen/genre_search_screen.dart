import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/genre_search/genre_search_bloc.dart';
import 'package:kuma_flutter_app/enums/category_click_status.dart';
import 'package:kuma_flutter_app/enums/genre_title.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/genre_data.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/model/item/animation_genre_search_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/date_util.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/empty_container.dart';
import 'package:kuma_flutter_app/widget/image_item.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';

class GenreSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
    final AppBar appBar = AppBar(
      actions: [Container()],
      title: Text('장르검색'),
    );
    final appBarHeight = appBar.preferredSize.height;

    return BlocBuilder<GenreSearchBloc, GenreSearchState>(
      builder: (context, state) {
        List<AnimationGenreSearchItem> genreSearchItems = state is GenreSearchLoadSuccess ? state.genreSearchItems : [];
        Map<String, CategoryClickStatus> clickMap = state.clickMap;
        GenreData genreData = state is GenreSearchLoadSuccess ? state.genreData : GenreData();

        return Stack(
          children: [
            Scaffold(
              key: _key,
              endDrawerEnableOpenDragGesture: false,
              endDrawer: _buildNavigationView(height: appBarHeight , genreData: genreData, clickMap: clickMap),
              appBar: appBar,
              body: Column(
                children: [
                  _buildTopContainer(key: _key),
                  _buildFilterContainer(clickMap: clickMap),
                  _buildGridView(context: context, genreSearchItems: genreSearchItems)
                ],
              ),
            ),
            LoadingIndicator(
              isVisible: state is GenreSearchLoadInProgress,
            )
          ],
        );
      },
    );
  }
  _buildFilterContainer({ Map<String, CategoryClickStatus> clickMap}){
    return Visibility(
      visible: clickMap.isNotEmpty,
      child: Container(
        height: kGenreItemHeight,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: kBlack, width: 0.1),
                bottom: BorderSide(color: kBlack, width: 0.1))),
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Icon(
              Icons.check_box,
              color: Colors.purple,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 30,
                child: ListView.separated(
                  itemBuilder: (context, idx) {
                    final String item = clickMap.keys.elementAt(idx);
                    return Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 0.5, color: kBlack)),
                      child: Row(
                        children: [
                          CustomText(
                            fontFamily: doHyunFont,
                            text: item,
                            fontSize: 10.0,
                          ),
                          Icon(
                            Icons.close,
                            size: 10,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, idx) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: clickMap.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTopContainer({ GlobalKey<ScaffoldState> key}){
    return Container(
      height: kGenreItemHeight,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          CustomText(
            fontFamily: doHyunFont,
            fontColor: Colors.black,
            text: "선택된 필터",
            fontSize: 14.0,
          ),
          Spacer(),
          GestureDetector(
            onTap: () => key.currentState.openEndDrawer(),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius:
                  BorderRadius.all(Radius.circular(5)),
                ),
                padding: EdgeInsets.only(right: 10, left: 10),
                height: 30,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      fontWeight: FontWeight.w700,
                      text: "필터",
                      fontColor: kWhite,
                      fontSize: 10.0,
                    ),
                    Icon(
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

  _buildGridView({BuildContext context, List<AnimationGenreSearchItem> genreSearchItems}){
    return genreSearchItems.isNotEmpty ? Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          scrollDirection: Axis.vertical,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          children: genreSearchItems
              .map((data) => GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, Routes.IMAGE_DETAIL,
                arguments: AnimationDetailPageItem(
                    id: data.id,
                    title: data.title)),
            child: Container(
                child: Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: ImageItem(
                          imgRes: data.image,
                          type: ImageShapeType.FLAT,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                        flex: 1,
                        child: CustomText(
                          fontSize: 10.0,
                          text: data.title,
                          maxLines: 2,
                          fontWeight: FontWeight.w700,
                          isEllipsis: true,
                          textAlign: TextAlign.center,
                        ))
                  ],
                )),
          ))
              .toList(),
        ),
      ),
    )
    : Expanded(
    child: EmptyContainer(
    title: "검색 목록 없음",
    ),
    );
  }

  _buildNavigationView({double height , GenreData genreData , Map<String, CategoryClickStatus> clickMap}){
    return SafeArea(
      child: Drawer(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Container(
              color: kBlack,
              width: double.infinity,
              height: height,
              child: DrawerHeader(
                child: SizedBox(),
              ),
            ),
            GenreItems(
              title: "장르",
              genreTitle: GenreTitle.GENRE,
              clickMap: clickMap,
              genreData: genreData,
            ),
            GenreItems(
              title: "연도",
              genreTitle: GenreTitle.YEAR,
              clickMap: clickMap,
              genreData: genreData,
            ),
            GenreItems(
              title: "방영",
              genreTitle: GenreTitle.AIRING,
              clickMap: clickMap,
              genreData: genreData,
            ),
            GenreItems(
              title: "나이제한",
              genreTitle: GenreTitle.RATED,
              clickMap: clickMap,
              genreData: genreData,
            )
          ],
        ),
      ),
    );
  }
}

class GenreItems extends StatefulWidget {
  final String title;
  final GenreTitle genreTitle;
  final Map<String, CategoryClickStatus> clickMap;
  final GenreData genreData;

  GenreItems({this.title, this.genreTitle, this.clickMap, this.genreData});

  @override
  _GenreItemsState createState() => _GenreItemsState();
}

class _GenreItemsState extends State<GenreItems> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    Map<String, String> genreMap = _getGenreMap(title: widget.genreTitle);

    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 60,
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
                    child: Text(widget.title),
                  ),
                  Spacer(),
                  isVisible
                      ? Icon(Icons.arrow_drop_up_outlined)
                      : Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          ),
          Visibility(
            visible: isVisible,
            child: Container(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Column(
                  children: genreMap.entries.map((data) {
                String key = data.key;
                String value = data.value;
                CategoryClickStatus status = widget.clickMap.containsKey(key)
                    ? widget.clickMap[key]
                    : CategoryClickStatus.NONE;
                return GenreCategoryItem(
                  category: key,
                  categoryValue: value,
                  clickMap: widget.clickMap,
                  clickStatus: status,
                  genreTitle: widget.genreTitle,
                  genreData: widget.genreData,
                );
              }).toList()),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> _getGenreMap({GenreTitle title}) {
    switch (title) {
      case GenreTitle.GENRE:
        return genreList;
      case GenreTitle.YEAR:
        return getFourYearMapData();
      case GenreTitle.AIRING:
        return airList;
      case GenreTitle.RATED:
        return ratedList;
      default:
        return {};
    }
  }
}

class GenreCategoryItem extends StatelessWidget {

  final String category;
  final String categoryValue;
  Map<String, CategoryClickStatus> clickMap;
  CategoryClickStatus clickStatus;
  final GenreTitle genreTitle;
  final GenreData genreData;

  GenreCategoryItem(
      {this.category,
      this.categoryValue,
      this.clickMap,
      this.clickStatus,
      this.genreTitle,
      this.genreData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _changeCategoryStatus(clickStatus);
        GenreData genreData = _getGenreData();
        BlocProvider.of<GenreSearchBloc>(context)
            .add(GenreLoad(data: genreData, clickMap: clickMap));
      },
      child: Container(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: CustomText(
                text: category,
                fontColor: (clickStatus == CategoryClickStatus.INCLUDE ||
                        clickStatus == CategoryClickStatus.EXCLUDE)
                    ? Colors.purple
                    : kBlack,
              ),
            ),
            Spacer(),
            _buildCategoryIcon(clickStatus)
          ],
        ),
      ),
    );
  }

  _changeCategoryStatus(CategoryClickStatus status) {
    switch (status) {
      case CategoryClickStatus.INCLUDE:
        if (genreTitle == GenreTitle.GENRE) {
          clickMap.update(category, (v) => CategoryClickStatus.EXCLUDE);
          clickStatus = CategoryClickStatus.EXCLUDE;
        } else {
          clickMap..remove(category);
          clickStatus = CategoryClickStatus.NONE;
        }
        break;
      case CategoryClickStatus.EXCLUDE:
        clickMap..remove(category);
        clickStatus = CategoryClickStatus.NONE;
        break;
      case CategoryClickStatus.NONE:
        clickMap..addAll({category: CategoryClickStatus.INCLUDE});
        clickStatus = CategoryClickStatus.INCLUDE;
        break;
    }
  }

  _buildCategoryIcon(CategoryClickStatus status) {
    switch (status) {
      case CategoryClickStatus.INCLUDE:
        return Icon(
          Icons.check_box,
          color: Colors.purple,
        );
      case CategoryClickStatus.EXCLUDE:
        return Icon(Icons.indeterminate_check_box_outlined,
            color: Colors.purple);
      case CategoryClickStatus.NONE:
        return Icon(Icons.check_box_outline_blank);
    }
  }

  _getGenreData() {
    switch (genreTitle) {
      case GenreTitle.GENRE:
        String genre = genreData.genre;
        String genreExclude = genreData.genreExclude;

        if (clickStatus == CategoryClickStatus.EXCLUDE) {
          genreExclude = _appendComma(baseString: genreExclude, appendString: categoryValue);
        } else if (clickStatus == CategoryClickStatus.INCLUDE) {
          genre = _appendComma(baseString: genre, appendString: categoryValue);
        } else {
          genre = _makeCategoryString(splitString: genre);
          genreExclude = _makeCategoryString(splitString: genreExclude);
        }
        return genreData.copyWith(genre: genre, genreExclude: genreExclude);
      case GenreTitle.YEAR:
        String startDate = categoryValue.split("~").first;
        String endDate = categoryValue.split("~").last;

        if (genreData.startDate.isNotEmpty && genreData.endDate.isNotEmpty) {
          if (clickStatus == CategoryClickStatus.NONE) {
            if (DateTime.parse(endDate).year > DateTime.parse(genreData.endDate).year)
              endDate = getFourYearMapData()[DateTime.parse(genreData.endDate).year.toString()]
                  .split("~")
                  .last;
            if (DateTime.parse(startDate).year == DateTime.parse(genreData.startDate).year)
              startDate = getFourYearMapData()[DateTime.parse(genreData.endDate).year.toString()]
                  .split("~")
                  .first;
          } else {
            if (DateTime.parse(startDate).year > DateTime.parse(genreData.startDate).year)
              startDate = genreData.startDate;
            if (DateTime.parse(endDate).year < DateTime.parse(genreData.endDate).year)
              endDate = genreData.endDate;
          }
        }
        return genreData.copyWith(startDate: startDate, endDate: endDate);
      case GenreTitle.AIRING:
        String airing = "";
        if (clickStatus == CategoryClickStatus.INCLUDE) airing = categoryValue;
        return genreData.copyWith(status: airing);
      case GenreTitle.RATED:
        String rated = genreData.rated;
        if (clickStatus == CategoryClickStatus.INCLUDE) rated = _appendComma(baseString: rated, appendString: categoryValue);
        else rated = _makeCategoryString(splitString: rated);
        return genreData.copyWith(rated: rated);
    }
  }

  _appendComma({String baseString, String appendString}) {
    if (baseString.isEmpty) baseString = appendString;
     else baseString += ",$appendString";
    return baseString;
  }

  _makeCategoryString({String splitString}) {
    return splitString.split(",").fold("", (acc, string) {
          if (categoryValue != string)
            acc = _appendComma(baseString: acc, appendString: string);
          return acc;
        }) ??
        "";
  }
}
