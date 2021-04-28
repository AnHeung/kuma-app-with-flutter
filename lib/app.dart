import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/account/account_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_detail/animation_detail_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_schedule/animation_schedule_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_season/animation_season_bloc.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/bloc/genre_search/genre_category_list_bloc/genre_category_list_bloc.dart';
import 'package:kuma_flutter_app/bloc/genre_search/genre_search_bloc.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/bloc/register/register_bloc.dart';
import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';
import 'package:kuma_flutter_app/bloc/search_history/search_history_bloc.dart';
import 'package:kuma_flutter_app/bloc/setting/setting_bloc.dart';
import 'package:kuma_flutter_app/bloc/splash/splash_bloc.dart';
import 'package:kuma_flutter_app/bloc/tab/tab_cubit.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/repository/firebase_client.dart';
import 'package:kuma_flutter_app/repository/firebase_store_client.dart';
import 'package:kuma_flutter_app/repository/rest_client.dart';
import 'package:kuma_flutter_app/repository/search_api_client.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/account_screen.dart';
import 'package:kuma_flutter_app/screen/animation_detail_screen.dart';
import 'package:kuma_flutter_app/screen/animation_schedule_screen.dart';
import 'package:kuma_flutter_app/screen/first_screen.dart';
import 'package:kuma_flutter_app/screen/home_screen.dart';
import 'package:kuma_flutter_app/screen/login_screen.dart';
import 'package:kuma_flutter_app/screen/notification_screen.dart';
import 'package:kuma_flutter_app/screen/register_screen.dart';
import 'package:kuma_flutter_app/screen/search_screen.dart';
import 'package:kuma_flutter_app/screen/setting_screen.dart';
import 'package:kuma_flutter_app/screen/splash_screen.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) {
        final dio = Dio()
          ..options =
          BaseOptions(receiveTimeout: 15000, connectTimeout: 15000)
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
        final FirebaseClient firebaseClient = FirebaseClient();

        return ApiRepository(
            restClient: restClient,
            searchApiClient: searchApiClient,
            firebaseClient: firebaseClient );
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TabCubit(),),
        BlocProvider(create: (context) {
          return AuthBloc(repository: context.read<ApiRepository>());
        }),
          BlocProvider(create: (context) =>SettingBloc(repository: context.read<ApiRepository>())),
          BlocProvider(create: (context) => GenreCategoryListBloc(repository: context.read<ApiRepository>())..add(GenreCategoryListLoad()))
        ],
        child: BlocListener<AuthBloc, AuthState>(
          child:  MaterialApp(
            title: "쿠마앱",
            theme: ThemeData(
              fontFamily: doHyunFont,
              primarySwatch: createMaterialColor(kBlack),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: Routes.SPLASH,
            routes: {
              Routes.SPLASH: (context) =>
                  BlocProvider(
                    create: (_) =>
                    SplashBloc(repository: context.read<ApiRepository>() , authBloc: BlocProvider.of<AuthBloc>(context))..add(SplashLoad()),
                    child: SplashScreen(),
                  ),
              Routes.FIRST_LAUNCH: (context) =>
                  BlocProvider(
                    create: (_) =>
                        SplashBloc(repository: context.read<ApiRepository>()),
                    child: FirstScreen(),
                  ),
              Routes.HOME: (context) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => AnimationBloc(repository: context.read<ApiRepository>(),settingBloc: BlocProvider.of<SettingBloc>(context))..add(AnimationLoad())),
                    BlocProvider(create: (_) => AnimationSeasonBloc(repository: context.read<ApiRepository>(),settingBloc: BlocProvider.of<SettingBloc>(context))..add(AnimationSeasonLoad(limit: "7"))),
                    BlocProvider(create: (_) => AnimationScheduleBloc(repository: context.read<ApiRepository>(),settingBloc: BlocProvider.of<SettingBloc>(context))..add(AnimationScheduleInitLoad())),
                    BlocProvider(create: (_) => GenreSearchBloc(repository: context.read<ApiRepository>(), genreCategoryListBloc: BlocProvider.of<GenreCategoryListBloc>(context))),
                  ],
                  child: HomeScreen(),
                );
              },
              Routes.IMAGE_DETAIL: (context) =>
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) =>
                            AnimationDetailBloc(
                                repository: context.read<ApiRepository>()),
                      ),
                    ],
                    child:  AnimationDetailScreen(),
                  ),
              Routes.SEARCH: (context) =>
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(
                          create: (_) =>
                              SearchBloc(
                                  repository: context.read<ApiRepository>())),
                      BlocProvider(
                          create: (_) =>
                              SearchHistoryBloc(
                                  repository: context.read<ApiRepository>()))
                    ],
                    child: SearchScreen(),
                  ),
              Routes.LOGIN: (context) =>
                  BlocProvider(
                    create: (context) => LoginBloc(repository: context.read<ApiRepository>()),
                    child: LoginScreen(),
                  ),
              Routes.REGISTER : (_)=> BlocProvider(create:(context)=>RegisterBloc(repository: context.read<ApiRepository>()) , child: RegisterScreen(),),
              Routes.Account : (context)=> BlocProvider(create:(_)=>AccountBloc(repository: context.read<ApiRepository>())..add(AccountLoad()) , child: AccountScreen(),),
              Routes.Notification : (context)=> BlocProvider(create:(_)=>RegisterBloc(repository: context.read<ApiRepository>()) , child: NotificationScreen(),),
              Routes.Setting : (context)=>SettingScreen(),
              Routes.SCHEDULE : (_)=>BlocProvider(create:(context)=>AnimationScheduleBloc(repository: context.read<ApiRepository>())..add(AnimationScheduleLoad(day: "1")) , child: AnimationScheduleScreen(),),
            },
          ),
          listener: (context,state){
            print(state);
          },
        )
    ) ,);
  }
}
