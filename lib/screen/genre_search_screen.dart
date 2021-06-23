import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/genre_search/category_list/genre_category_list_bloc.dart';
import 'package:kuma_flutter_app/bloc/genre_search/search/genre_search_bloc.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/enums/category_click_status.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_detail_page_item.dart';
import 'package:kuma_flutter_app/model/item/animation_genre_search_item.dart';
import 'package:kuma_flutter_app/model/item/genre_data.dart';
import 'package:kuma_flutter_app/model/item/genre_nav_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';
import 'package:kuma_flutter_app/widget/common/empty_container.dart';
import 'package:kuma_flutter_app/widget/common/image_item.dart';
import 'package:kuma_flutter_app/widget/common/loading_indicator.dart';

class GenreSearchScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String initialPage = "1";

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      centerTitle: true,
      actions: [ Container(padding: const EdgeInsets.only(right: 10),child: IconButton(
        onPressed: ()=>showBaseDialog(title: "필터 삭제" , context: context , content: "필터를 전부 삭제하시겠습니까?" , confirmFunction: (){
          BlocProvider.of<GenreCategoryListBloc>(context).add(GenreItemRemoveAll());
          Navigator.pop(context);
        } ,),
        icon: const Icon(Icons.delete_outline_rounded),

    ))],
      title: const Text('장르검색'),
    );
    final appBarHeight = appBar.preferredSize.height;

    return BlocConsumer<GenreSearchBloc, GenreSearchState>(
      listener: (context,state){
        if(state.status == BaseBlocStateStatus.Failure) showToast(msg:state.msg);
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: ()async=> BlocProvider.of<GenreSearchBloc>(context).add(GenreLoad(data: state.genreData)),
          child: Stack(
            children: [
              Scaffold(
                key: _scaffoldKey,
                endDrawerEnableOpenDragGesture: false,
                endDrawer: _buildNavigationView(height: appBarHeight),
                appBar: appBar,
                body: Column(
                  children: [
                    _buildTopContainer(scaffoldKey: _scaffoldKey),
                    _buildFilterContainer(),
                    _buildTotalCountContainer(),
                    _buildGridView(context: context)
                  ],
                ),
              ),
              LoadingIndicator(
                isVisible: state.status == BaseBlocStateStatus.Loading,
              )
            ],
          ),
        );
      },
    );
  }

  _buildFilterContainer() {
    List<GenreNavItem> genreClickItems = [];

    return BlocBuilder<GenreCategoryListBloc, GenreCategoryListState>(
      builder: (context, state) {
        if (state.status == BaseBlocStateStatus.Success) {
          genreClickItems = state.genreListItems.fold([], (acc, genreItem) {
            genreItem.navItems
                .where((navItem) =>
                    navItem.clickStatus != CategoryClickStatus.None)
                .forEach((item) => acc.add(item));
            return acc;
          });
        }
        return Visibility(
          visible: genreClickItems.isNotEmpty,
          child: Container(
            height: kGenreItemHeight,
            decoration:const  BoxDecoration(
                border: Border(
                    top: BorderSide(color: kBlack, width: 0.1),
                    bottom: BorderSide(color: kBlack, width: 0.1))),
            padding:const  EdgeInsets.only(left: 10),
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
                          onTap: () =>
                              BlocProvider.of<GenreCategoryListBloc>(context)
                                  .add(GenreItemRemove(navItem: item)),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 4, bottom: 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 0.5, color: kBlack)),
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
                      separatorBuilder: (context, idx) {
                        return const SizedBox(
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

  _buildTotalCountContainer() {
    return BlocBuilder<GenreSearchBloc, GenreSearchState>(
      builder: (context, state) {
        return Container(
          decoration:const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: kBlack, width: 0.1))),
          alignment: Alignment.center,
          height: kGenreItemHeight,
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

  _buildTopContainer({GlobalKey<ScaffoldState> scaffoldKey}) {
    return Container(
      height: kGenreItemHeight,
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

  _buildGridView({BuildContext context}) {
    return BlocBuilder<GenreSearchBloc, GenreSearchState>(
      builder: (context, state) {
        List<AnimationGenreSearchItem> genreSearchItems =
            state.genreSearchItems;
        GenreData genreData = state.genreData;
        return GenreGridView(
          currentPage: state.currentPage,
          onLoadMore: (page)=>{
            BlocProvider.of<GenreSearchBloc>(context).add(GenreLoad(data: genreData ,page: page.toString()))
          },
          genreSearchItems: genreSearchItems,
          genreData: genreData,
        );
      },
    );
  }

  _buildNavigationView({double height}) {
    List<GenreListItem> genreListItems = [];

    return BlocBuilder<GenreCategoryListBloc, GenreCategoryListState>(
      builder: (context, state) {
        if (state.status == BaseBlocStateStatus.Success) {
          genreListItems = state.genreListItems;
        }
        return SafeArea(
          child: Drawer(
            child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: genreListItems
                    .map((item) => GenreItem(
                        genreListItem: item, genreListItems: genreListItems))
                    .toList()),
          ),
        );
      },
    );
  }

}

class GenreGridView extends StatefulWidget {
  final Function(int) onLoadMore;
  final List<AnimationGenreSearchItem> genreSearchItems;
  final GenreData genreData;
  final int currentPage;

  GenreGridView({genreSearchItems, genreData ,this.onLoadMore ,currentPage})
      : this.genreSearchItems = genreSearchItems ?? [],
        this.genreData = genreData ?? GenreData(),
        this.currentPage = currentPage ?? 1;


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

class GenreItem extends StatefulWidget {
  final GenreListItem genreListItem;
  final List<GenreListItem> genreListItems;

  GenreItem({this.genreListItem, this.genreListItems});

  @override
  _GenreItemsState createState() => _GenreItemsState();
}

class _GenreItemsState extends State<GenreItem> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
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
                    child: CustomText(
                      text: widget.genreListItem.koreaType,
                      fontSize: 15.0,
                      fontFamily: doHyunFont,
                    ),
                  ),
                  const Spacer(),
                  isVisible
                      ? const Icon(Icons.arrow_drop_up_outlined)
                      : const Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          ),
          Visibility(
            visible: isVisible,
            child: Container(
              padding:const  EdgeInsets.only(left: 20, bottom: 10),
              child: Column(
                  children: widget.genreListItem.navItems.map((navItem) {
                return GenreCategoryItem(
                  navItem: navItem,
                  genreListItems: widget.genreListItems,
                );
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

  GenreCategoryItem({this.navItem, this.genreListItems});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        BlocProvider.of<GenreCategoryListBloc>(context)
            .add(GenreItemClick(navItem: navItem));
      },
      child: Container(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: CustomText(
                fontFamily: doHyunFont,
                text: navItem.category,
                fontColor:
                    (navItem.clickStatus == CategoryClickStatus.Include ||
                            navItem.clickStatus == CategoryClickStatus.Exclude)
                        ? kPurple
                        : kBlack,
              ),
            ),
            const Spacer(),
            _buildCategoryIcon(navItem.clickStatus)
          ],
        ),
      ),
    );
  }

  _buildCategoryIcon(CategoryClickStatus status) {
    switch (status) {
      case CategoryClickStatus.Include:
        return const Icon(
          Icons.check_box_outlined,
          color: kPurple,
        );
      case CategoryClickStatus.Exclude:
        return const Icon(Icons.indeterminate_check_box_outlined, color: kPurple);
      case CategoryClickStatus.None:
        return const Icon(Icons.check_box_outline_blank);
    }
  }
}
