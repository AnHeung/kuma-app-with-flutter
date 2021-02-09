import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/bloc/splash/splash_bloc.dart';
import 'package:kuma_flutter_app/bloc/tab/tab_cubit.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/repository/rest_client.dart';
import 'package:kuma_flutter_app/repository/search_api_client.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/home_screen.dart';
import 'package:kuma_flutter_app/screen/splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) {
        final RestClient restClient = RestClient(Dio()
          ..options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000));
        final SearchApiClient searchApiClient = SearchApiClient(Dio()
          ..options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000));

        return ApiRepository(
            restClient: restClient, searchApiClient: searchApiClient);
      },
      child: MaterialApp(
        title: "쿠마앱",
        theme: ThemeData(
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
                  BlocProvider(create: (_) => AnimationBloc(repository: context.read<ApiRepository>())..add(AnimationLoad(rankType: "all",searchType: "all",limit: "30")),),
                ],
                child: HomeScreen(),
              ),
        },
      ),
    );
  }
}
