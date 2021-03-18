part of 'setting_bloc.dart';

@immutable
abstract class SettingState extends Equatable{

  @override
  List<Object> get props =>[];

  const SettingState();
}

class SettingLoadingInProgress extends SettingState {}


class SettingLoadFailure extends SettingState {
  final String errMsg;

  const SettingLoadFailure({this.errMsg});
}

class SettingLoadSuccess extends SettingState {

  final SettingConfig config;

  const SettingLoadSuccess({this.config});

  @override
  List<Object> get props =>[config];
}

class SettingChangeComplete extends SettingState {}

