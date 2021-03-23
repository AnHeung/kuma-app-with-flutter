part of 'account_bloc.dart';

@immutable
abstract class AccountState extends Equatable{


  @override
  List<Object> get props =>[];

  const AccountState();

}

class AccountLoadInProgress extends AccountState {
}
class AccountLoadFailure extends AccountState {
  final String errMsg;

  const AccountLoadFailure({this.errMsg});

  @override
  List<Object> get props =>[errMsg];
}

class AccountLoadSuccess extends AccountState {
  final UserAccount accountData;
  const AccountLoadSuccess({this.accountData});
}

class AccountWithdrawSuccess extends AccountState {
  final String successMsg;

  const AccountWithdrawSuccess({this.successMsg});

  @override
  List<Object> get props =>[successMsg];
}

class AccountWithdrawFailure extends AccountState {
  final String errMsg;

  const AccountWithdrawFailure({this.errMsg});

  @override
  List<Object> get props =>[errMsg];
}

