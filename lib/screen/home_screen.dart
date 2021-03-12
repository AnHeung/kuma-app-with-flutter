import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/bloc/more/more_bloc.dart';
import 'package:kuma_flutter_app/bloc/tab/tab_cubit.dart';
import 'package:kuma_flutter_app/enums/app_tab.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/animation_screen.dart';
import 'package:kuma_flutter_app/screen/image_screen.dart';
import 'package:kuma_flutter_app/screen/more_screen.dart';
import 'package:kuma_flutter_app/screen/torrent_screen.dart';
import 'package:kuma_flutter_app/widget/tab_selector.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TabCubit, AppTab>(builder: (context, currentTab) {
      return Scaffold(
        drawer: SafeArea(
          child: Drawer(
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
        body: _selectScreen(tab: currentTab, context: context),
        floatingActionButton: Visibility(
          visible: currentTab != AppTab.MORE,
          child: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, Routes.SEARCH),
            child: Icon(Icons.search),
          ),
        ),
        bottomNavigationBar: TabSelector(
          tab: currentTab,
          onTabSelected: (currentTab) =>
              BlocProvider.of<TabCubit>(context).tabUpdate(currentTab),
        ),
      );
    });
  }

  Widget _selectScreen({AppTab tab, BuildContext context}) {
    Widget widget = AnimationScreen();

    switch (tab) {
      case AppTab.ANIMATION:
        widget = AnimationScreen();
        break;
      case AppTab.TORRENT:
        widget = TorrentScreen();
        break;
      case AppTab.IMAGE:
        widget = ImageScreen();
        break;
      case AppTab.MORE:
        widget = BlocProvider(create: (_)=>MoreBloc(), child: MoreScreen(),);
        break;
    }
    return widget;
  }
}
