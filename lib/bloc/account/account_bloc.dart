import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
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
    yield AccountLoadInProgress();
    await repository.withdraw();
    await removeUserData();
  }

  Stream<AccountState> _mapToAccountLoad() async* {
    yield AccountLoadInProgress();
    User user = repository.user;
    SocialUserData data = await getUserData();
    String loginType = (data.socialType != SocialType.UNKNOWN &&
            data.socialType != SocialType.EMAIL)
        ? "소셜"
        : "이메일";

    yield AccountLoadSuccess(
        accountData: UserAccount(
            email: user.email,
            userName: user.displayName.isEmpty ? user.email : user.displayName,
            socialType: data.socialType,
            loginType: loginType));
  }
}