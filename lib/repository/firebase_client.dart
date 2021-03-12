import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/repository/kakao_client.dart';
import 'package:kuma_flutter_app/repository/social_client.dart';

class FirebaseClient{

  SocialClient socialClient;
  FirebaseAuth _firebaseAuth;


  FirebaseClient({FirebaseAuth firebaseAuth}): _firebaseAuth = firebaseAuth ??  FirebaseAuth.instance;

  Stream<User> get user {
    return FirebaseAuth.instance
        .authStateChanges();
 }

  Future<Map<LoginStatus, SocialUserData>> login({SocialType type, BuildContext context}) async{

    SocialUserData userData = SocialUserData.empty;

    try {
    switch(type){
      case SocialType.KAKAO :
        socialClient = KakaoClient(context: context);
        userData = await socialClient.login();
         break;
      case SocialType.GOOGLE :
        break;
    }

    await _firebaseAuth.signInWithEmailAndPassword(
        email: userData.email,
        password: userData.id
    );
    return {LoginStatus.LoginSuccess:userData};

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('해당 유저가 존재하지 않습니다. 회원가입하세요');
        return {LoginStatus.NeedRegister:userData};
      } else if (e.code == 'wrong-password') {
        print('비밀번호가 틀렸습니다. 다시 입력해주세요');
        return {LoginStatus.WrongPassword:userData};
      }else{
        print('파이어베이스 로그인 Exception $e');
        return {LoginStatus.Failure:userData};
      }
    }catch(e){
      print('signIn Exception $e');
      return {LoginStatus.Failure:userData};
    }
  }

  Future<void> logOut({SocialType type, BuildContext context}) async {
    try {

      switch(type){
        case SocialType.KAKAO :
          socialClient = KakaoClient(context: context);
          await socialClient.logout();
          return await _firebaseAuth.signOut();
        case SocialType.GOOGLE :
          break;
      }
    } on Exception {
      print('로그아웃 실패');
    }
  }

   Future<LoginStatus> register (String email, String pw) async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: pw
      );
      return LoginStatus.LoginSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return LoginStatus.WrongPassword;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return LoginStatus.Failure;
      }
    } catch (e) {
      print("register $e");
      return LoginStatus.Failure;
    }
}
}
