part of 'account_bloc.dart';

enum AccountStatus {Initial , Loading, Failure , Success , Withdraw}

@immutable
class AccountState extends Equatable{

  final String msg;
  final AccountStatus status;
  final UserAccount accountData;

  const AccountState({this.msg, this.status = AccountStatus.Initial, this.accountData = const UserAccount()});

  @override
  List<Object> get props =>[msg, status ,accountData];

  AccountState copyWith({
    String msg,
    AccountStatus status,
    UserAccount accountData,
  }) {
    if ((msg == null || identical(msg, this.msg)) &&
        (status == null || identical(status, this.status)) &&
        (accountData == null || identical(accountData, this.accountData))) {
      return this;
    }

    return new AccountState(
      msg: msg ?? this.msg,
      status: status ?? this.status,
      accountData: accountData ?? this.accountData,
    );
  }
}

