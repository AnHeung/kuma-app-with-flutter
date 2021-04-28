part of 'account_bloc.dart';

@immutable
abstract class AccountEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const AccountEvent();
}

class AccountLoad extends AccountEvent{}

class AccountWithdraw extends AccountEvent{

  final String userId;

  const AccountWithdraw({this.userId});

  @override
  List<Object> get props =>[userId];

}

