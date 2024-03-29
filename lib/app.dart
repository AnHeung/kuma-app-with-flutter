import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/account/account_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation/animation_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_detail/animation_detail_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_schedule/animation_schedule_bloc.dart';
import 'package:kuma_flutter_app/bloc/animation_season/animation_season_bloc.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/bloc/genre_search/category_list/genre_category_list_bloc.dart';
import 'package:kuma_flutter_app/bloc/genre_search/search/genre_search_bloc.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/bloc/more/more_bloc.dart';
import 'package:kuma_flutter_app/bloc/network/network_bloc.dart';
import 'package:kuma_flutter_app/bloc/news/animation_news_bloc.dart';
import 'package:kuma_flutter_app/bloc/notification/notification_bloc.dart';
import 'package:kuma_flutter_app/bloc/register/register_bloc.dart';
import 'package:kuma_flutter_app/bloc/search/search_bloc.dart';
import 'package:kuma_flutter_app/bloc/search_history/search_history_bloc.dart';
import 'package:kuma_flutter_app/bloc/setting/setting_bloc.dart';
import 'package:kuma_flutter_app/bloc/splash/splash_bloc.dart';
import 'package:kuma_flutter_app/bloc/subscribe/subscribe_bloc.dart';
import 'package:kuma_flutter_app/bloc/tab/tab_cubit.dart';
import 'package:kuma_flutter_app/model/item/app_env_item.dart';
import 'package:kuma_flutter_app/repository/api_client.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/repository/firebase_client.dart';
import 'package:kuma_flutter_app/repository/search_api_client.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/screen.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class App extends StatefulWidget {

  AppEnvItem envItem;

  @override
  _AppState createState() => _AppState();

  App({this.envItem});
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "MainNavigator");

  AppLifecycleState _appLifecycleState;
  bool isDialogOpen = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('_appLifecycleState $_appLifecycleState');
    setState(() {
      _appLifecycleState = state;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bool isRelease = const bool.fromEnvironment('dart.vm.product');
    return RepositoryProvider(
      create: (_) {
        final dio = Dio()
          ..options = BaseOptions(receiveTimeout: 15000, connectTimeout: 15000, headers: { widget.envItem.API_KEY : widget.envItem.API_KEY_VALUE })
          ..interceptors.add(PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: false,
              responseHeader: false,
              logPrint: (object) => log(object),
              error: true,
              compact: true,
              maxWidth: 90));

        final ApiClient apiClient = ApiClient(dio , baseUrl: widget.envItem.API_URL);
        final SearchApiClient searchApiClient = SearchApiClient(dio, baseUrl: widget.envItem.SEARCH_API_URL);
        final FirebaseClient firebaseClient = FirebaseClient(envItem: widget.envItem);

        return ApiRepository(
            apiClient: apiClient,
            searchApiClient: searchApiClient,
            firebaseClient: firebaseClient);
      },
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TabCubit(),
            ),
            BlocProvider(create: (context) => NetworkBloc()),
            BlocProvider(create: (context) => AuthBloc(repository: context.read<ApiRepository>())),
            BlocProvider(create: (context) => SettingBloc(repository: context.read<ApiRepository>())),
            BlocProvider(create: (context) => GenreCategoryListBloc(repository: context.read<ApiRepository>())), BlocProvider(create: (context) => LoginBloc(repository: context.read<ApiRepository>())),
            BlocProvider(
                create: (context) => NotificationBloc(
                    repository: context.read<ApiRepository>(),
                    loginBloc: BlocProvider.of<LoginBloc>(context))
                  ..add(NotificationLoad())),
          ],
          child: BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              BuildContext currentContext = navigatorKey.currentState.overlay.context;
              switch (state.status) {
                case NetworkStatus.Disconnect:
                  showNetworkErrorDialog(context: currentContext);
                  isDialogOpen = true;
                  break;
                case NetworkStatus.Terminate:
                  showToast(msg: kRetryInfoMsg);
                  SystemNavigator.pop();
                  return;
                case NetworkStatus.Connect:
                  if (isDialogOpen) {
                    Navigator.of(currentContext).pop();
                  };
                  isDialogOpen = false;
                  break;
              }
            },
            child: MaterialApp(
              navigatorKey: navigatorKey,
              title: kAppTitle,
              theme: ThemeData(
                fontFamily: doHyunFont,
                primarySwatch: createMaterialColor(kBlack),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              routes: {
                Routes.SPLASH: (context) => BlocProvider(
                      create: (_) => SplashBloc(
                          networkBloc: BlocProvider.of<NetworkBloc>(context),
                          repository: context.read<ApiRepository>(),
                          authBloc: BlocProvider.of<AuthBloc>(context))
                        ..add(SplashLoad()),
                      child: SplashScreen(),
                    ),
                Routes.FIRST_LAUNCH: (context) => BlocProvider(
                    create: (_) => SplashBloc(
                        networkBloc: BlocProvider.of<NetworkBloc>(context),
                        repository: context.read<ApiRepository>(),),
                    child: FirstScreen()),
                Routes.HOME: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                          create: (_) => AnimationBloc(
                              repository: context.read<ApiRepository>(),
                              settingBloc: BlocProvider.of<SettingBloc>(context),
                              loginBloc: BlocProvider.of<LoginBloc>(context))..add(AnimationLoad())),
                      BlocProvider(
                          create: (_) => AnimationSeasonBloc(
                              repository: context.read<ApiRepository>(),
                              settingBloc:
                                  BlocProvider.of<SettingBloc>(context))..add(AnimationSeasonLoad(limit: kSeasonLimitCount))),
                      BlocProvider(
                          create: (_) => AnimationScheduleBloc(
                              repository: context.read<ApiRepository>(),
                              settingBloc:
                                  BlocProvider.of<SettingBloc>(context))..add(AnimationScheduleLoad(day: "1"))),
                      BlocProvider(
                          create: (_) => GenreSearchBloc(
                              repository: context.read<ApiRepository>(),
                              genreCategoryListBloc:
                                  BlocProvider.of<GenreCategoryListBloc>(
                                      context)..add(GenreCategoryListLoad()))),
                      BlocProvider(
                        create: (context) => AnimationNewsBloc(
                            repository: context.read<ApiRepository>())..add(const AnimationNewsLoad(page: "1")),
                      ),
                      BlocProvider(
                        create: (_) => MoreBloc(),
                      )
                    ],
                    child: HomeScreen(),
                  );
                },
                Routes.IMAGE_DETAIL: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(create: (_) => AnimationDetailBloc(repository: context.read<ApiRepository>()),),
                        BlocProvider(create: (context) => SubscribeBloc(repository: context.read<ApiRepository>()))
                      ],
                      child: AnimationDetailScreen(),
                    ),
                Routes.SEARCH: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                            create: (_) => SearchBloc(
                                repository: context.read<ApiRepository>())),
                        BlocProvider(
                            create: (_) => SearchHistoryBloc(
                                repository: context.read<ApiRepository>())..add(SearchHistoryLoad()))
                      ],
                      child: SearchScreen(),
                    ),
                Routes.LOGIN: (context) => LoginScreen(),
                Routes.REGISTER: (_) => BlocProvider(
                      create: (context) => RegisterBloc(
                          repository: context.read<ApiRepository>()),
                      child: RegisterScreen(),
                    ),
                Routes.Account: (context) => BlocProvider(
                      create: (_) =>
                          AccountBloc(repository: context.read<ApiRepository>())
                            ..add(AccountLoad()),
                      child: AccountScreen(),
                    ),
                Routes.Notification: (context) => NotificationScreen(),
                Routes.Setting: (context) => SettingScreen(),
                Routes.SCHEDULE: (_) => BlocProvider(
                      create: (context) => AnimationScheduleBloc(
                          repository: context.read<ApiRepository>())
                        ..add(AnimationScheduleLoad(day: "1")),
                      child: AnimationScheduleScreen(),
                    ),
              },
            ),
          )),
    );
  }
}
