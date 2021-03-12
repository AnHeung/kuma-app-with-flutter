import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/enums/app_tab.dart';

class TabSelector extends StatelessWidget {

  final AppTab tab;
  final Function(AppTab) onTabSelected;

  TabSelector({this.tab, this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor:Colors.deepPurpleAccent,
      currentIndex: AppTab.values.indexOf(tab),
      onTap: (index)=>onTabSelected(AppTab.values[index]),
      items:
        AppTab.values
        .map((tab)=>BottomNavigationBarItem(
          icon: Icon(_makeTabRes(tab)),
          title: Text(_makeTabTitle(tab))
        )).toList()
    );
  }

  String _makeTabTitle(AppTab tab) {
    String title;

    switch (tab) {
      case AppTab.ANIMATION:
        title = "애니";
        break;
      case AppTab.TORRENT:
        title = "토렌트";
        break;
      case AppTab.IMAGE:
        title = "이미지";
        break;
      case AppTab.MORE:
        title = "더보기";
        break;
    }
    return title;
  }

  _makeTabRes(AppTab tab) {
    IconData icon = Icons.terrain;

    switch (tab) {
      case AppTab.ANIMATION:
        icon = Icons.album;
        break;
      case AppTab.TORRENT:
        icon = Icons.phone_android;
        break;
      case AppTab.IMAGE:
        icon = Icons.image;
        break;
      case AppTab.MORE:
        icon = Icons.more_horiz;
        break;
    }
    return icon;
  }
}
