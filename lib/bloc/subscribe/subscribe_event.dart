part of 'subscribe_bloc.dart';

@immutable
abstract class SubscribeEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const SubscribeEvent();
}

class SubscribeUpdate extends SubscribeEvent{

  final SubscribeItem item;
  final bool isSubScribe;

  const SubscribeUpdate({this.item,  this.isSubScribe = false});

  @override
  List<Object> get props =>[item,isSubScribe];
}


class CheckSubscribe extends SubscribeEvent{

  final String animationId;

  const CheckSubscribe({this.animationId});

  @override
  List<Object> get props =>[animationId];
}
