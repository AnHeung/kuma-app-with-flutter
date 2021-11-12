part of 'screen.dart';

class GenreSearchScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreSearchBloc, GenreSearchState>(
      builder: (context, state) {
        if (state.status == BaseBlocStateStatus.Failure) {
          showToast(msg: state.msg);
        }
        return RefreshIndicator(
          onRefresh: () async => BlocProvider.of<GenreSearchBloc>(context)
              .add(GenreLoad(data: state.genreData)),
          child: Stack(
            children: [
              Scaffold(
                key: _scaffoldKey,
                endDrawerEnableOpenDragGesture: false,
                endDrawer: GenreSearchNavigationView(),
                appBar: GenreSearchAppbar(),
                body: Column(
                  children: [
                    GenreSearchTopContainer(scaffoldKey: _scaffoldKey),
                    GenreSearchFilterContainer(),
                    GenreSearchTotalCountContainer(),
                    GenreSearchGridView()
                  ],
                ),
              ),
              LoadingIndicator(
                isVisible: state.status == BaseBlocStateStatus.Loading,
              )
            ],
          ),
        );
      },
    );
  }
}
