import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/genre_search/category_list/genre_category_list_bloc.dart';
import 'package:kuma_flutter_app/bloc/genre_search/search/genre_search_bloc.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:kuma_flutter_app/widget/common/loading_indicator.dart';
import 'package:kuma_flutter_app/widget/common/refresh_container.dart';
import 'package:kuma_flutter_app/widget/genre_search/genre_search_widget.dart';

class GenreSearchScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String initialPage = "1";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreSearchBloc, GenreSearchState>(
      builder: (context, state) {
        if (state.status == BaseBlocStateStatus.Failure) {
          showToast(msg: state.msg);
          return RefreshContainer(
            callback: () => BlocProvider.of<GenreCategoryListBloc>(context)
                .add(GenreCategoryListLoad()),
          );
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
