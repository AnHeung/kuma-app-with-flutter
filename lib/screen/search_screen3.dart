// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';
// import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
// import 'package:kuma_flutter_app/model/item/animation_search_item.dart';
// import 'package:kuma_flutter_app/routes/routes.dart';
// import 'package:kuma_flutter_app/util/view_utils.dart';
// import 'package:kuma_flutter_app/widget/loading_indicator.dart';
// import 'package:kuma_flutter_app/widget/search_history_item.dart';
// import 'package:kuma_flutter_app/widget/search_image_item.dart';
// import 'package:rxdart/rxdart.dart';
//
// class SearchScreen extends StatefulWidget {
//
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
//
//   final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
//   List<AnimationSearchItem> searchItemList = [];
//   List<AnimationSearchItem> list = [];
//   final TextEditingController searchController = TextEditingController();
//   Icon _searchIcon = Icon(Icons.search);
//   Widget _appBarTitle = Text('검색페이지');
//   PublishSubject<String> searchSubject = PublishSubject();
//   // Animation<double> _opacity;
//   final int durationTime = 500;
//
//
//   AnimationController _opacityController;
//
//   _createSearchEngine() {
//     searchSubject.stream
//         .debounce(
//             (_) => TimerStream(true, Duration(milliseconds: durationTime)))
//         .where((value) {
//       return value.isNotEmpty && value.toString().length > 0;
//     }).listen((query) {
//       if (!searchSubject.isClosed)
//         BlocProvider.of<SearchBloc>(context)
//             .add(SearchLoad(searchQuery: query));
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _createSearchEngine();
//     searchController?.addListener(_searchListener);
//     BlocProvider.of<SearchBloc>(context).add(SearchHistoryLoad());
//    //  _opacityController = AnimationController(duration: Duration(seconds: 500),vsync: this);
//    //
//    // _opacity = CurvedAnimation(parent: _opacityController, curve: Curves.easeInOut)..addStatusListener((status) {
//    //    if (status == AnimationStatus.completed) {
//    //      _opacityController.reverse();
//    //    } else if (status == AnimationStatus.dismissed) {
//    //      _opacityController.forward();
//    //    }
//    //  });
//    //  _opacityController.forward();
//
//   }
//
//   @override
//   void dispose() {
//     searchController?.dispose();
//     searchSubject?.close();
//     // _opacityController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: _appBarTitle,
//         actions: [
//           IconButton(
//             onPressed: _searchPressed,
//             icon: _searchIcon,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 5),
//             child: IconButton(
//               onPressed: () => showBaseDialog(
//                   context: context,
//                   title: "기록 전체삭제",
//                   content: "저장된 기록을 다 지우시겠습니까?",
//                   confirmFunction: () {
//                     BlocProvider.of<SearchBloc>(context)
//                         .add(SearchHistoryClear());
//                     Navigator.pop(context);
//                   }),
//               icon: Icon(Icons.delete),
//             ),
//           ),
//         ],
//       ),
//       body: BlocListener<SearchBloc, SearchState>(
//         listener: (context, state) {
//           switch (state.runtimeType) {
//             case SearchLoadFailure:
//               String errMsg = (state as SearchLoadFailure).errMsg ?? "에러";
//               showToast(msg: errMsg);
//               break;
//             case ClearSearchScreen:
//               setState(() {
//                 this._searchIcon = Icon(Icons.search);
//                 this._appBarTitle = Text('검색페이지');
//                 _clearScreen();
//               });
//               break;
//             case InitialSearchScreen:
//               setState(() {
//                 this._searchIcon = Icon(Icons.close);
//                 this._appBarTitle = TextField(
//                   autofocus: true,
//                   controller: searchController,
//                   decoration: InputDecoration(hintText: '검색...'),
//                 );
//               });
//               break;
//           }
//         },
//         child: Stack(
//           children: <Widget>[
//             _searchHistoryView(),
//             _searchItemView(),
//             BlocBuilder<SearchBloc, SearchState>(
//               builder: (context, state) => LoadingIndicator(
//                 isVisible: state is SearchLoadInProgress,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   _searchHistoryView() {
//     return BlocBuilder<SearchBloc, SearchState>(
//       buildWhen: (prev, cur) => cur is SearchHistoryLoadSuccess,
//       builder: (context, state) {
//         List<AnimationSearchItem> list =
//             (state is SearchHistoryLoadSuccess) ? state.list : [];
//         return Container(
//           margin: EdgeInsets.only(top: 30),
//           child: SearchHistoryItem(
//             list: list,
//           ),
//         );
//       },
//     );
//   }
//
//   _searchItemView() {
//     return BlocBuilder<SearchBloc, SearchState>(
//       buildWhen: (prev, cur) => cur is SearchItemLoadSuccess,
//       builder: (context, state) {
//         searchItemList = (state is SearchItemLoadSuccess) ? state.list : [];
//         return Visibility(
//           visible: searchItemList.isNotEmpty,
//           child: Container(
//             constraints: BoxConstraints(
//                 minHeight: 100,
//                 minWidth: double.infinity,
//                 maxHeight: MediaQuery.of(context).size.height * 0.4),
//             color: Colors.blue,
//             child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   ListView(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     children: searchItemList
//                         .map((searchItem) => SearchImageItem(
//                               imgRes: searchItem.image,
//                               title: searchItem.title,
//                               onTap: () {
//                                 BlocProvider.of<SearchBloc>(context).add(SearchClear());
//                                 BlocProvider.of<SearchBloc>(context).add(
//                                     SearchHistoryWrite(
//                                         searchItem: AnimationSearchItem(
//                                             id: searchItem.id,
//                                             image: searchItem.image,
//                                             title: searchItem.title)));
//                                 Navigator.pushNamed(context, Routes.IMAGE_DETAIL,
//                                     arguments: RankingItem(
//                                         id: searchItem.id, title: searchItem.title));
//                               },
//                             ))
//                         .toList(),
//                   ),
//                 ],
//               ),
//             ),
//         );
//       },
//     );
//   }
//
//   void _searchPressed() {
//     BlocProvider.of<SearchBloc>(context).add(SearchBtnClick(isClick: this._searchIcon.icon != Icons.search));
//   }
//
//   _clearScreen() {
//       searchItemList.clear();
//       searchController.text = "";
//       searchController.clear();
//   }
//
//   _searchListener() {
//     if (searchController.text.isEmpty)
//       _clearScreen();
//     else
//       searchSubject.add(searchController.text);
//   }
// }
