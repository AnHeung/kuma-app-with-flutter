part of 'screen.dart';

class HomeScreen extends StatelessWidget {

  final List<Widget> homeScreenList = [AnimationScreen() , GenreSearchScreen(), AnimationNewsScreen(), MoreScreen()];

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
