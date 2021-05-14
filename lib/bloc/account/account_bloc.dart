import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/login_user.dart';
import 'package:kuma_flutter_app/model/user_account.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final ApiRepository repository;

  AccountBloc({this.repository}) : super(const AccountState(status: AccountStatus.initial));

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is AccountLoad) {
      yield* _mapToAccountLoad();
    } else if (event is AccountWithdraw) {
      yield* _mapToWithdraw(event);
    }
  }

  Stream<AccountState> _mapToWithdraw(AccountWithdraw event) async* {
    try {
      yield const AccountState(status: AccountStatus.loading);
      String userId  = event.userId;
      bool withdrawResult = await repository.withdraw(userId);
      if (withdrawResult) yield const AccountState(status: AccountStatus.withdraw, msg: "회원탈퇴 성공");
      else yield const AccountState(status :AccountStatus.failure, msg: "회원탈퇴 실패 다시 시도해주세요");
    }catch(e){
      yield AccountState(status :AccountStatus.failure, msg: "회원탈퇴 오류 : $e");
    }
  }

  Stream<AccountState> _mapToAccountLoad() async* {
    yield const AccountState(status: AccountStatus.loading);
    LoginUserData userData = await getUserData();

    yield AccountState(
      status: AccountStatus.success,
        accountData: UserAccount(
            userId: userData.userId,
            userName: userData.userName.isNullEmptyOrWhitespace ? userData.userId : userData.userName,
            loginType: userData.loginType));
  }
}
