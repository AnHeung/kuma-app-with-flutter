import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/app_tab.dart';

class TabSelector extends StatelessWidget {

  final AppTab tab;
  final Function(AppTab) onTabSelected;

  const TabSelector({this.tab, this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor:kPurple,
      currentIndex: AppTab.values.indexOf(tab),
      onTap: (index)=>onTabSelected(AppTab.values[index]),
      items:
        AppTab.values
        .map((tab)=>BottomNavigationBarItem(
          icon: Icon(_makeTabRes(tab)),
          label: _makeTabTitle(tab),
        )).toList()
    );
  }

  String _makeTabTitle(AppTab tab) {
    String title;

    switch (tab) {
      case AppTab.Animation:
        title = "애니";
        break;
      case AppTab.Genre:
        title = "장르검색";
        break;
      case AppTab.News:
        title = "뉴스";
        break;
      case AppTab.More:
        title = "더보기";
        break;
    }
    return title;
  }

  _makeTabRes(AppTab tab) {
    IconData icon = Icons.terrain;

    switch (tab) {
      case AppTab.Animation:
        icon = Icons.album;
        break;
      case AppTab.Genre:
        icon = Icons.phone_android_sharp;
        break;
      case AppTab.News:
        icon = Icons.update_sharp;
        break;
      case AppTab.More:
        icon = Icons.more_horiz;
        break;
    }
    return icon;
  }
}
