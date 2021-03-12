import 'package:equatable/equatable.dart';

abstract class BaseState<T> extends Equatable{

  T t;

  String msg;

  BaseState.loadSuccess({this.t});

  BaseState.loadFailure({this.msg});

  BaseState.loading();

  BaseState({this.t});

  @override
  List<Object> get props =>[];
}