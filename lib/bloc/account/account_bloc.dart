import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/model/user_account.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final ApiRepository repository;

  AccountBloc({this.repository}) : super(AccountLoadInProgress());

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is AccountLoad) {
      yield* _mapToAccountLoad();
    } else if (event is AccountWithdraw) {
      yield* _mapToWithdraw();
    }
  }

  Stream<AccountState> _mapToWithdraw() async* {
    try {
      yield AccountLoadInProgress();
      bool withdrawResult = await repository.withdraw();
      if (withdrawResult)
        yield const AccountWithdrawSuccess(successMsg: "회원탈퇴 성공");
      else
        yield const AccountWithdrawFailure(errMsg: "회원탈퇴 실패 다시 시도해주세요");
    }catch(e){
      yield AccountWithdrawFailure(errMsg: "회원탈퇴 오류 : $e");
    }
  }

  Stream<AccountState> _mapToAccountLoad() async* {
    yield AccountLoadInProgress();
    User user = repository.user;
    LoginUserData data = await getUserData();

    yield AccountLoadSuccess(
        accountData: UserAccount(
            email: user.email,
            userName: user.displayName.isEmpty ? user.email : user.displayName,
            loginType: data.loginType));
  }
}
