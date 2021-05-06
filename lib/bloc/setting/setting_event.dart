part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const SettingEvent();
}

class SettingLoad extends SettingEvent{}

class ChangeSetting extends SettingEvent {

  final SettingConfig config;

  const ChangeSetting({this.config});

  @override
  List<Object> get props=>[config];
}

class SettingScreenExit extends SettingEvent {}