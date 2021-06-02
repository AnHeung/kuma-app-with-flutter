import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';
import 'package:kuma_flutter_app/bloc/search_history/search_history_bloc.dart';
import 'package:kuma_flutter_app/enums/image_shape_type.dart';
import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
import 'package:kuma_flutter_app/model/item/base_scroll_item.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/inner_text_grid_container.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/search_image_item.dart';

import '../model/item/animation_deatil_page_item.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = CustomText(
    text: '검색페이지',
    fontColor: kWhite,
    fontFamily: doHyunFont,
    fontSize: 17.0,
  );
  List<AnimationSearchItem> searchItemList;
  List<AnimationSearchItem> searchHistoryList;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchHistoryBloc>(context).add(SearchHistoryLoad());
    return BlocConsumer<SearchBloc, SearchState>(listener: (context, state) {
      if (state.status == SearchStatus.Failure) {
        String errMsg = state.msg ?? "에러";
        showToast(msg: errMsg);
      } else if (state.status == SearchStatus.Clear) {
        _clearSearchBar();
      } else if (state.status == SearchStatus.Set) {
        print('setSearchScreen');
        _setSearchBar(context);
      } else if (state.status == SearchStatus.Initial) {
        print('initial');
        _initialSearchBar();
      }
    }, builder: (context, state) {
      searchItemList = state.list ?? [];
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _searchAppbar(context),
        body: Stack(
          children: <Widget>[
            _searchHistoryView(),
            _searchItemView(context),
            LoadingIndicator(
              isVisible: state.status == SearchStatus.Loading,
            )
          ],
        ),
      );
    });
  }

  _searchAppbar(BuildContext context) {
    return AppBar(
      title: _appBarTitle,
      actions: [
        _searchActionWidget(context),
        _deleteHistoryActionWidget(context),
      ],
    );
  }

  _searchActionWidget(BuildContext context) {
    return IconButton(
      onPressed: () => BlocProvider.of<SearchBloc>(context)
          .add(SearchBtnClick(isClick: _searchIcon.icon == Icons.search)),
      icon: _searchIcon,
    );
  }

  _deleteHistoryActionWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: IconButton(
        onPressed: () => showBaseDialog(
            context: context,
            title: "기록 전체삭제",
            content: "저장된 기록을 다 지우시겠습니까?",
            confirmFunction: () {
              BlocProvider.of<SearchHistoryBloc>(context)
                  .add(SearchHistoryClear());
              Navigator.pop(context);
            }),
        icon: const Icon(Icons.delete),
      ),
    );
  }

  _initialSearchBar() {
    _searchIcon = const Icon(Icons.search);
    _appBarTitle = CustomText(
      text: '검색페이지',
      fontColor: kWhite,
      fontFamily: doHyunFont,
      fontWeight: FontWeight.w700,
      fontSize: 17.0,
    );
    searchItemList.clear();
  }

  _clearSearchBar() {
    _appBarTitle = CustomText(
      text: '',
      fontColor: kWhite,
      fontFamily: doHyunFont,
      fontWeight: FontWeight.w700,
      fontSize: 17.0,
    );
    searchItemList.clear();
  }

  _setSearchBar(BuildContext context) {
    _searchIcon = const Icon(Icons.close);
    _appBarTitle = TextField(
      style: const TextStyle(color: kWhite),
      onChanged: (value) {
        print('value:$value');
        BlocProvider.of<SearchBloc>(context)
            .add(SearchQueryUpdate(searchQuery: value));
      },
      autofocus: true,
      decoration: const InputDecoration(
        hintText: '검색...',
        hintStyle: const TextStyle(color: kWhite),
      ),
      cursorColor: kWhite,
    );
  }

  _searchHistoryView() {
    return BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
      buildWhen: (prev, cur) => cur.status == SearchHistoryStatus.Success,
      builder: (context, state) {
        searchHistoryList =  state.list;
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: InnerTextGridContainer(
            imageShapeType: ImageShapeType.CIRCLE,
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
        );
      },
    );
  }

  _searchItemView(BuildContext context) {
    return Visibility(
      visible: searchItemList.isNotEmpty,
      child: Container(
        constraints: BoxConstraints(
            minHeight: 50,
            minWidth: double.infinity,
            maxHeight: MediaQuery.of(context).size.height * 0.6),
        color: kBlack,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: searchItemList
              .map((searchItem) => SearchImageItem(
            imgRes: searchItem.image,
            title: searchItem.title,
            onTap: () {
              BlocProvider.of<SearchHistoryBloc>(context).add(
                  SearchHistoryWrite(
                      searchItem: AnimationSearchItem(
                          id: searchItem.id,
                          image: searchItem.image,
                          title: searchItem.title)));
              BlocProvider.of<SearchBloc>(context).add(SearchClear());
              Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
                  arguments: AnimationDetailPageItem(
                      id: searchItem.id.toString(),
                      title: searchItem.title));
            },
          ))
              .toList(),
        ),
      ),
    );
  }
}

//
// class SearchScreen2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<SearchHistoryBloc>(context).add(SearchHistoryLoad());
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: SearchAppbar(),
//       body: Stack(
//         children: <Widget>[
//           _searchHistoryView(),
//           _searchItemView(context),
//         ],
//       ),
//     );
//   }
//
//   _searchItemView(BuildContext context) {
//     return BlocBuilder<SearchBloc,SearchState>(builder: (context,state){
//       List<AnimationSearchItem> list = state.list;
//       return Container(
//           constraints: BoxConstraints(
//               minHeight: 50,
//               minWidth: double.infinity,
//               maxHeight: MediaQuery.of(context).size.height * 0.6),
//           color: kBlack,
//           child: ListView(
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             children: list
//                 .map((searchItem) => SearchImageItem(
//               imgRes: searchItem.image,
//               title: searchItem.title,
//               onTap: () {
//                 BlocProvider.of<SearchHistoryBloc>(context).add(
//                     SearchHistoryWrite(
//                         searchItem: AnimationSearchItem(
//                             id: searchItem.id,
//                             image: searchItem.image,
//                             title: searchItem.title)));
//                 BlocProvider.of<SearchBloc>(context).add(SearchClear());
//                 Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
//                     arguments: AnimationDetailPageItem(
//                         id: searchItem.id.toString(),
//                         title: searchItem.title));
//               },
//             ))
//                 .toList(),
//           ),
//       );
//     },);
//   }
//
//   _searchHistoryView() {
//     return BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
//       buildWhen: (prev, cur) => cur.status == SearchHistoryStatus.Success,
//       builder: (context, state) {
//         List<AnimationSearchItem> searchHistoryList = state.list;
//         return Stack(
//           children: [
//             Container(
//               margin: const EdgeInsets.only(top: 30),
//               child: InnerTextGridContainer(
//                 imageShapeType: ImageShapeType.CIRCLE,
//                 gridCount: 3,
//                 list: searchHistoryList
//                     .map((item) => BaseScrollItem(
//                     id: item.id,
//                     title: item.title,
//                     image: item.image,
//                     onTap: () {
//                       BlocProvider.of<SearchHistoryBloc>(context).add(
//                           SearchHistoryWrite(
//                               searchItem: AnimationSearchItem(
//                                   id: item.id,
//                                   image: item.image,
//                                   title: item.title)));
//                       Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
//                           arguments: AnimationDetailPageItem(
//                               id: item.id.toString(), title: item.title));
//                     }))
//                     .toList(),
//               ),
//             ),
//             LoadingIndicator(isVisible: state.status == SearchHistoryStatus.Loading,)
//           ],
//         );
//       },
//     );
//   }
// }
//
//
//
// class SearchAppbar extends StatefulWidget implements PreferredSizeWidget{
//
//   SearchAppbar({Key key})
//       : preferredSize = const Size.fromHeight(kToolbarHeight),
//         super(key: key);
//
//   @override
//   final Size preferredSize;
//
//   @override
//   _SearchAppbarState createState() => _SearchAppbarState();
//
// }
//
// class _SearchAppbarState extends State<SearchAppbar> {
//
//   bool isClick = false;
//   Icon _searchIcon = const Icon(Icons.search);
//   Widget _appBarTitle = CustomText(
//     text: '검색페이지',
//     fontColor: kWhite,
//     fontFamily: doHyunFont,
//     fontSize: 17.0,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SearchBloc, SearchState>(listener: (context, state) {
//       if (state.status == SearchStatus.Failure) {
//         String errMsg = state.msg ?? "에러";
//         showToast(msg: errMsg);
//       }
//     }, builder: (context, state) {
//       return AppBar(
//         title: _appBarTitle,
//         actions: [
//           _searchActionWidget(context),
//           _deleteHistoryActionWidget(context),
//         ],
//       );
//     });
//   }
//
//
//   _initialSearchBar() {
//     setState(() {
//       _searchIcon = const Icon(Icons.search);
//       _appBarTitle = CustomText(
//         text: '검색페이지',
//         fontColor: kWhite,
//         fontFamily: doHyunFont,
//         fontWeight: FontWeight.w700,
//         fontSize: 17.0,
//       );
//     });
//     // searchItemList.clear();
//   }
//
//   _clearSearchBar() {
//     setState(() {
//       _appBarTitle = CustomText(
//         text: '',
//         fontColor: kWhite,
//         fontFamily: doHyunFont,
//         fontWeight: FontWeight.w700,
//         fontSize: 17.0,
//       );
//     });
//     // searchItemList.clear();
//   }
//
//   _setSearchBar(BuildContext context) {
//     _searchIcon = const Icon(Icons.close);
//     _appBarTitle = TextField(
//       style: const TextStyle(color: kWhite),
//       onChanged: (value) {
//         print('value:$value');
//         BlocProvider.of<SearchBloc>(context)
//             .add(SearchQueryUpdate(searchQuery: value));
//       },
//       autofocus: true,
//       decoration: const InputDecoration(
//         hintText: '검색...',
//         hintStyle: const TextStyle(color: kWhite),
//       ),
//       cursorColor: kWhite,
//     );
//   }
//
//   _deleteHistoryActionWidget(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 5),
//       child: IconButton(
//         onPressed: () => showBaseDialog(
//             context: context,
//             title: "기록 전체삭제",
//             content: "저장된 기록을 다 지우시겠습니까?",
//             confirmFunction: () {
//               BlocProvider.of<SearchHistoryBloc>(context)
//                   .add(SearchHistoryClear());
//               Navigator.pop(context);
//             }),
//         icon: const Icon(Icons.delete),
//       ),
//     );
//   }
//
//   _changeAppbarIcon(){
//     setState(() {
//       isClick = !isClick;
//       if(isClick){
//         _searchIcon = const Icon(Icons.close);
//       }else{
//         _searchIcon = const Icon(Icons.search);
//       }
//     });
//
//   }
//
//   _searchActionWidget(BuildContext context) {
//     return IconButton(
//       onPressed: () => _changeAppbarIcon(),
//       icon: _searchIcon,
//     );
//   }
// }

