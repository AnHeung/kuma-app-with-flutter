import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/enums/register_status.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/repository/kakao_client.dart';
import 'package:kuma_flutter_app/repository/social_client.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';

class FirebaseClient {
  SocialClient socialClient;
  FirebaseAuth _firebaseAuth;

  FirebaseClient({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  get user {
    return FirebaseAuth.instance.currentUser;
  }

  Stream<User> get userStream {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<Map<LoginStatus, SocialUserData>> login(
      {SocialType type, BuildContext context}) async {
    SocialUserData userData = SocialUserData.empty;

    try {
      switch (type) {
        case SocialType.KAKAO:
          socialClient = KakaoClient();
          userData = await socialClient.login();
          break;
        case SocialType.GOOGLE:
          print('소셜 타입 구글');
          break;
        case SocialType.EMAIL:
          print('소셜 타입 이메일');
          break;
        case SocialType.UNKNOWN:
          return {LoginStatus.Failure: userData};
      }
      if (userData == null) return {LoginStatus.CheckEmail: userData};
      print('userData $userData');
      await _firebaseAuth
          .signInWithEmailAndPassword(
              email: userData.email, password: userData.uniqueId)
          .then((result) =>
              result.user.updateProfile(displayName: userData.userName))
          .then((result) async => await saveUserData(userData: userData))
          .catchError((e) {
        var errorCode = e.code;
        var errMsg = e.message;
        print('errorCode :$errorCode errMsg : $errMsg');
        throw FirebaseAuthException(message: errMsg, code: errorCode);
      });
      return {LoginStatus.LoginSuccess: userData};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('해당 유저가 존재하지 않습니다. 회원가입하세요');
        return {LoginStatus.NeedRegister: userData};
      } else if (e.code == 'wrong-password') {
        print('비밀번호가 틀렸습니다. 다시 입력해주세요');
        return {LoginStatus.WrongPassword: userData};
      } else {
        print('파이어베이스 로그인 Exception $e');
        return {LoginStatus.Failure: userData};
      }
    } catch (e) {
      print('signIn Exception $e');
      return {LoginStatus.Failure: userData};
    }
  }

  Future<bool> logout() async {
    try {
      SocialUserData data = await getUserData();
      if (data.socialType != null) {
        switch (data.socialType) {
          case SocialType.KAKAO:
            socialClient = KakaoClient();
            break;
          case SocialType.GOOGLE:
            break;
          case SocialType.EMAIL:
            break;
          case SocialType.UNKNOWN:
            print('로그아웃 실패');
            return false;
        }
        await socialClient.logout();
      }
      return await _firebaseAuth.signOut()
            .then((res)async=>await removeUserData())
            .then((res)=>true)
            .catchError((e) async{
         print("logout  User Exception $e");
          await _reAuthenticateUser()
              .then((res) async {
                 await logout();
              }).catchError((e) {
                 var errorCode = e.code;
               var errMsg = e.message;
               throw Exception("logout 오류 발생 :$errMsg 코드:$errorCode}");
        });
      });
    } on Exception catch (e) {
      print('로그아웃 실패 :$e');
      return false;
    }
  }

  Future<bool> withdraw() async {
    try {
      return await _firebaseAuth.currentUser.delete().then((res) async {
        await removeUserData();
        print('계정 삭제 성공');
        return true;
      }).catchError((err) async {
        print("withdraw  User Exception $err");
        await _reAuthenticateUser()
              .then((res) async {
                await withdraw();
             }).catchError((e) {
              var errorCode = e.code;
              var errMsg = e.message;
              throw Exception("회원탈퇴 오류 발생 :$errMsg 코드:$errorCode}");
           });
      });
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  _reAuthenticateUser() async {
    SocialUserData userData = await getUserData();
    var credential = EmailAuthProvider.credential(
        email: userData.email, password: userData.uniqueId);

    return _firebaseAuth.currentUser.reauthenticateWithCredential(credential);
  }

  Future<RegisterStatus> register({SocialUserData userData}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: userData.email, password: userData.uniqueId)
          .then((result) {
        result.user.updateProfile(displayName: userData.userName);
      });

      return RegisterStatus.RegisterComplete;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('비밀번호가 너무 짧습니다.');
        return RegisterStatus.RegisterFailure;
      } else if (e.code == 'email-already-in-use') {
        print(RegisterStatus.AlreadyInUse.msg);
        return RegisterStatus.AlreadyInUse;
      } else {
        print("register FirebaseAuthException $e");
        return RegisterStatus.RegisterFailure;
      }
    } catch (e) {
      print("register Exception $e");
      return RegisterStatus.RegisterFailure;
    }
  }
}
