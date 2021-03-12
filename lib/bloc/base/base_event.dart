import 'package:equatable/equatable.dart';

abstract class BaseEvent<T> extends Equatable{

  T data;

  String msg;

  BaseEvent.loadSuccess({this.data});

  BaseEvent.loadFailure({this.msg});

  BaseEvent.loading();

  BaseEvent({this.data});

  @override
  List<Object> get props =>[];
}