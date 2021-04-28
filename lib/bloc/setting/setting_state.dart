part of 'setting_bloc.dart';

enum SettingStatus {initial , loading , failure , success , complete}

@immutable
class SettingState extends Equatable{

  final SettingStatus status;
  final String msg;
  final SettingConfig config;

  @override
  List<Object> get props =>[status , msg, config];

  const SettingState({this.status,this.msg, this.config});
}




