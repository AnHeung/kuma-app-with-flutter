import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_detail/animation_detail_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_season/animation_season_bloc.dart';
import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';
import 'package:kuma_flutter_app/bloc/search_history/search_history_bloc.dart';
import 'package:kuma_flutter_app/bloc/splash/splash_bloc.dart';
import 'package:kuma_flutter_app/bloc/tab/tab_cubit.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/repository/rest_client.dart';
import 'package:kuma_flutter_app/repository/search_api_client.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/animation_detail_screen.dart';
import 'package:kuma_flutter_app/screen/home_screen.dart';
import 'package:kuma_flutter_app/screen/search_screen.dart';
import 'package:kuma_flutter_app/screen/splash_screen.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) {
        final dio = Dio()..options = BaseOptions(receiveTimeout: 15000, connectTimeout: 15000)
          ..interceptors.add(PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: false,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90));

        final RestClient restClient = RestClient(dio);
        final SearchApiClient searchApiClient = SearchApiClient(dio);

        return ApiRepository(
            restClient: restClient, searchApiClient: searchApiClient);
      },
      child: MaterialApp(
        title: "쿠마앱",
        theme: ThemeData(
          fontFamily: 'NanumPenScript',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Routes.SPLASH,
        routes: {
          Routes.SPLASH: (context) =>
              BlocProvider(
                create: (_) =>
                SplashBloc(repository: context.read<ApiRepository>())
                  ..add(SplashInit()),
                child: SplashScreen(),
              ),
          Routes.HOME: (context) =>
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => TabCubit(),),
                  BlocProvider(create: (_) => AnimationBloc(repository: context.read<ApiRepository>())..add(AnimationLoad(rankType: "all",searchType: "all",limit: "30" ))),
                  BlocProvider(create: (_) => AnimationSeasonBloc(repository: context.read<ApiRepository>())..add(AnimationSeasonLoad(limit: "7"))),
                ],
                child: HomeScreen(),
              ),
      // BlocProvider.of<AnimationDetailBloc>(context).add(AnimationDetailLoad(id: item.id.toString(), type:"all"));
          Routes.IMAGE_DETAIL: (context)=>BlocProvider(
            create: (_)=> AnimationDetailBloc(repository: context.read<ApiRepository>()),
            child: AnimationDetailScreen(),
          ),
          Routes.SEARCH: (context)=>MultiBlocProvider(
            providers: [
            BlocProvider(create: (_)=> SearchBloc(repository: context.read<ApiRepository>())),
              BlocProvider(create: (_)=> SearchHistoryBloc(repository: context.read<ApiRepository>()))
            ],
            child: SearchScreen(),
          )
        },
      ),
    );
  }
}
