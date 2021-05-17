part of 'subscribe_bloc.dart';

@immutable
abstract class SubscribeEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const SubscribeEvent();
}

class SubscribeUpdate extends SubscribeEvent{

  final String animationId;
  final bool isSubScribe;

  const SubscribeUpdate({this.animationId , this.isSubScribe = false});

  @override
  List<Object> get props =>[animationId];
}


class CheckSubscribe extends SubscribeEvent{

  final String animationId;

  const CheckSubscribe({this.animationId});

  @override
  List<Object> get props =>[animationId];
}
