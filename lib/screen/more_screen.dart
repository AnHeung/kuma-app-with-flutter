part of 'screen.dart';

enum MoreType {Account  , Setting, VersionInfo, Logout}

extension  MoreTypeExtension on MoreType{

  get icon {

    switch(this){
      case MoreType.Account :
        return Icons.account_circle;
      case MoreType.VersionInfo :
        return Icons.info_outline;
      case MoreType.Setting :
        return Icons.settings;
      case MoreType.Logout :
        return Icons.logout;
    }
  }

  get title{
    switch(this){
      case MoreType.Account :
        return kMoreAccountTitle;
      case MoreType.Logout :
        return kLogoutInfoTitle;
      case MoreType.VersionInfo :
        return kMoreVersionInfoTitle;
      case MoreType.Setting :
        return kMoreSettingTitle;
    }
  }
}

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final status = context.select((AuthBloc bloc) => bloc.state.status);
        if (status == AuthStatus.Auth) {
          return MoreTopContainer();
        }else if(status == AuthStatus.UnKnown) {
          return const LoadingIndicator(isVisible: true,);
        }else {
          return NeedLoginContainer();
        }
      },
    );
  }
}
