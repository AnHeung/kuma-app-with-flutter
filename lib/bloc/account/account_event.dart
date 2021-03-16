part of 'account_bloc.dart';

@immutable
abstract class AccountEvent extends Equatable{

  @override
  List<Object> get props =>[];

}

class AccountLoad extends AccountEvent{}

class AccountWithdraw extends AccountEvent{}

