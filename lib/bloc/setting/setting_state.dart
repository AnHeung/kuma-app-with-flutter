part of 'setting_bloc.dart';

enum SettingStatus {Initial , Loading , Failure , Success , Complete}

@immutable
class SettingState extends Equatable{

  final SettingStatus status;
  final String msg;
  final SettingConfig config;

  @override
  List<Object> get props =>[status , msg, config];

  SettingState copyWith({
    SettingStatus status,
    String msg,
    SettingConfig config,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (msg == null || identical(msg, this.msg)) &&
        (config == null || identical(config, this.config))) {
      return this;
    }

    return SettingState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      config: config ?? this.config,
    );
  }

  SettingState initialConfigState(){
    return SettingState(
      status: SettingStatus.Initial,
      msg: "",
      config: SettingConfig(),
    );
  }

  const SettingState({this.status,this.msg, this.config});
}




