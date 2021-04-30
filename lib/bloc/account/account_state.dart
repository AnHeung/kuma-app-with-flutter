part of 'account_bloc.dart';

enum AccountStatus {initial , loading, failure , success , withdraw}

@immutable
class AccountState extends Equatable{

  final String msg;
  final AccountStatus status;
  final UserAccount accountData;

  const AccountState({this.msg, this.status = AccountStatus.initial, this.accountData = const UserAccount()});

  @override
  List<Object> get props =>[msg, status ,accountData];

}

