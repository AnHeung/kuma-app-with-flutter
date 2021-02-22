import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';


class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return  AppBar(
        title:  Text('검색페이지'),
        actions: [searchBar.getSearchAction(context)]
    );
  }

  _SearchScreenState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar
    );
  }

  @override
  Widget build(BuildContext context) {

    return  BlocBuilder<SearchBloc, SearchState>(
      builder: (context,state)=>Scaffold(
        appBar: searchBar.build(context),
        body: ListView(
          children: [

          ],
        ),
      ),
    );
  }
}
