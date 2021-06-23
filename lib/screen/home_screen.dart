import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/tab/tab_cubit.dart';
import 'package:kuma_flutter_app/enums/app_tab.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/animation_screen.dart';
import 'package:kuma_flutter_app/screen/genre_search_screen.dart';
import 'package:kuma_flutter_app/screen/more_screen.dart';
import 'package:kuma_flutter_app/screen/news_screen.dart';
import 'package:kuma_flutter_app/widget/home/tab_selector.dart';

class HomeScreen extends StatelessWidget {

  final List<Widget> homeScreenList = [AnimationScreen() , GenreSearchScreen(), NewsScreen(), MoreScreen()];

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TabCubit, AppTab>(builder: (context, currentTab) {

      if(currentTab != AppTab.News) FocusManager.instance.primaryFocus?.unfocus();

      return Scaffold(
        body:  IndexedStack(children: homeScreenList ,index: currentTab.index,),
        floatingActionButton: Visibility(
          visible: currentTab != AppTab.More && currentTab != AppTab.News,
          child: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, Routes.SEARCH),
            child: const Icon(Icons.search),
          ),
        ),
        bottomNavigationBar: TabSelector(
          tab: currentTab,
          onTabSelected: (currentTab)=> BlocProvider.of<TabCubit>(context).tabUpdate(currentTab),
        ),
      );
    });
  }
}
