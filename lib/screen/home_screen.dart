import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/bloc/tab/tab_cubit.dart';
import 'package:kuma_flutter_app/enums/app_tab.dart';
import 'package:kuma_flutter_app/screen/image_screen.dart';
import 'package:kuma_flutter_app/screen/torrent_screen.dart';
import 'package:kuma_flutter_app/screen/animation_screen.dart';
import 'package:kuma_flutter_app/widget/tab_selector.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TabCubit , AppTab>(
        builder: (context, currentTab){
          return Scaffold(
            drawer: SafeArea(
              child: Drawer(
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
            appBar: AppBar(
              title: Text('메인'),
            ),
            body: _selectScreen(tab:currentTab,context: context),
            floatingActionButton: FloatingActionButton(
              onPressed: ()=>print('ㅌㅅㅌㅅ'),
              child: Icon(Icons.search),
            ),
            bottomNavigationBar: TabSelector(tab: currentTab, onTabSelected: (currentTab)=>BlocProvider.of<TabCubit>(context).tabUpdate(currentTab),),
          );
        }
    );
  }

  Widget _selectScreen({AppTab tab, BuildContext context}){

    Widget widget = TorrentScreen();

    switch(tab){
      case AppTab.ANIMATION :
        BlocProvider.of<AnimationBloc>(context).add(AnimationLoad(rankType: "all",searchType: "all",limit: "30"));
        widget = AnimationScreen();
        break;
      case AppTab.TORRENT :
        widget = TorrentScreen();
        break;
      case AppTab.IMAGE :
        widget = ImageScreen();
        break;
    }
    return widget;
  }
}
