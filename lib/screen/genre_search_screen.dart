import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/genre_search/genre_category_list_bloc/genre_category_list_bloc.dart';
import 'package:kuma_flutter_app/bloc/genre_search/genre_search_bloc.dart';
import 'package:kuma_flutter_app/enums/category_click_status.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_deatil_page_item.dart';
import 'package:kuma_flutter_app/model/item/animation_genre_search_item.dart';
import 'package:kuma_flutter_app/model/item/genre_nav_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
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
      builder: (context,state){
        return Stack(
          children: [
            Scaffold(
                key: _key,
                endDrawerEnableOpenDragGesture: false,
                endDrawer: _buildNavigationView(height: appBarHeight),
                appBar: appBar,
                body: Column(
                          children: [
                            _buildTopContainer(key: _key),
                            _buildFilterContainer(),
                            _buildGridView(context: context)
                          ],
                        ),
            ),
            LoadingIndicator(isVisible: state is GenreSearchLoadInProgress,)
          ],
        );
      },
    );
  }

  _buildFilterContainer() {

    List<GenreListItem> genreListItems = [];
    List<GenreNavItem> genreClickItems = [];

    return BlocBuilder<GenreCategoryListBloc, GenreCategoryListState>(
      builder: (context, state) {
        if (state is GenreListLoadSuccess) {
          genreListItems = state.genreListItems;
          genreClickItems = state.genreListItems.fold([], (acc, genreItem) {
            genreItem.navItems
                .where((navItem) =>
                    navItem.clickStatus != CategoryClickStatus.NONE)
                .forEach((item) => acc.add(item));
            return acc;
          });
        }
        return Visibility(
          visible: genreClickItems.isNotEmpty,
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
                    height: 20,
                    child: ListView.separated(
                      itemBuilder: (context, idx) {
                        final GenreNavItem item = genreClickItems[idx];
                        return GestureDetector(
                          onTap: ()=> BlocProvider.of<GenreCategoryListBloc>(context).add(GenreItemRemove(navItem: item , genreListItems:genreListItems)),
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5 , top: 2, bottom: 2),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 0.5, color: kBlack)),
                            child: Row(
                              children: [
                                CustomText(
                                  fontFamily: doHyunFont,
                                  text: item.category,
                                  fontSize: 10.0,
                                ),
                                Icon(
                                  Icons.close,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, idx) {
                        return SizedBox(
                          width: 10,
                        );
                      },
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

  _buildTopContainer({GlobalKey<ScaffoldState> key}) {
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
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                padding: EdgeInsets.only(right: 10, left: 10),
                height: 30,
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

  _buildGridView({BuildContext context}) {
    List<AnimationGenreSearchItem> genreSearchItems = [];

    return BlocBuilder<GenreSearchBloc, GenreSearchState>(
      builder: (context, state) {
        if (state is GenreSearchLoadSuccess) {
          genreSearchItems = state.genreSearchItems;
        }
        return genreSearchItems.isNotEmpty
            ? Expanded(
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
                        id: data.id, title: data.title)),
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
      },
    );
  }

  _buildNavigationView({double height}) {
    List<GenreListItem> genreListItems = [];

    return BlocBuilder<GenreCategoryListBloc, GenreCategoryListState>(
      builder: (context, state) {
        if (state is GenreListLoadSuccess) {
         genreListItems = state.genreListItems;
        }
        return SafeArea(
          child: Drawer(
            child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: genreListItems
                              .map((item) => GenreItem(
                                    genreListItem: item,
                                  genreListItems:genreListItems
                                  ))
                              .toList()),
          ),
        );
      },
    );
  }
}

class GenreItem extends StatefulWidget {
  final GenreListItem genreListItem;
  final List<GenreListItem> genreListItems;

  GenreItem({this.genreListItem,this.genreListItems});

  @override
  _GenreItemsState createState() => _GenreItemsState();
}

class _GenreItemsState extends State<GenreItem> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
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
                    child: Text(widget.genreListItem.koreaType),
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
                  children: widget.genreListItem.navItems.map((navItem) {
                return GenreCategoryItem(navItem: navItem, genreListItems: widget.genreListItems,);
              }).toList()),
            ),
          )
        ],
      ),
    );
  }
}

class GenreCategoryItem extends StatelessWidget {

  final List<GenreListItem> genreListItems;
  final GenreNavItem navItem;

  GenreCategoryItem({
    this.navItem,
    this.genreListItems
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        BlocProvider.of<GenreCategoryListBloc>(context).add(GenreItemClick(navItem: navItem , genreListItems: genreListItems));
      },
      child: Container(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: CustomText(
                text: navItem.category,
                fontColor: (navItem.clickStatus == CategoryClickStatus.INCLUDE ||
                    navItem.clickStatus == CategoryClickStatus.EXCLUDE)
                    ? Colors.purple
                    : kBlack,
              ),
            ),
            Spacer(),
            _buildCategoryIcon(navItem.clickStatus)
          ],
        ),
      ),
    );
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
}
