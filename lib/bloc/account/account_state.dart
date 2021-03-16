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
}

class AccountLoadSuccess extends AccountState {
  final UserAccount accountData;
  const AccountLoadSuccess({this.accountData});
}

class AccountWithdrawSuccess extends AccountState {

}

