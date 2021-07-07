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
          icon: Icon(tab.icon),
          label: tab.title,
        )).toList()
    );
  }
}
