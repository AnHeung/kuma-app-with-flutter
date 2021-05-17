import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/enums/register_status.dart';
import 'package:kuma_flutter_app/model/api/login_user.dart';
import 'package:kuma_flutter_app/repository/email_client.dart';
import 'package:kuma_flutter_app/repository/google_client.dart';
import 'package:kuma_flutter_app/repository/kakao_client.dart';
import 'package:kuma_flutter_app/repository/social_client.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:kuma_flutter_app/util/string_util.dart';

class FirebaseClient {
  LoginClient loginClient;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  get user => FirebaseAuth.instance.currentUser;

  Stream<User> get userStream => FirebaseAuth.instance.authStateChanges();

  Future<Map<LoginStatus, LoginUserData>> login(
      {LoginType type, BuildContext context}) async {
    LoginUserData userData = LoginUserData.empty;
    try {
      switch (type) {
        case LoginType.KAKAO:
          loginClient = KakaoClient();
          break;
        case LoginType.GOOGLE:
          loginClient = GoogleClient();
          break;
        case LoginType.EMAIL:
          loginClient = EmailClient();
          break;
        default:
          return {LoginStatus.Failure: userData};
      }
      userData = await loginClient.login();
      if (userData == null) return {LoginStatus.Failure: userData};
      if (userData.uniqueId == null && userData.loginType == LoginType.EMAIL)
        return {LoginStatus.NeedLoginScreen: userData};

      return firebaseSignIn(userData: userData);
    } catch (e) {
      print("firebaseClient login Error :$e");
      return {LoginStatus.Failure: userData};
    }
  }

  Future<Map<LoginStatus, LoginUserData>> firebaseSignIn(
      {LoginUserData userData}) async {
    try {
      return await _firebaseAuth
          .signInWithEmailAndPassword(
              email: userData.userId,
              password: userData.uniqueId.getEncryptString())
          .then((result) => getUserItemFromFireStore(userId: userData.userId))
          .then((fireStoreUserData) async {
        await saveUserData(userData: fireStoreUserData);
        return {LoginStatus.LoginSuccess: fireStoreUserData};
      }).catchError((e) {
        var errorCode = e.code;
        var errMsg = e.message;
        print('errorCode :$errorCode errMsg : $errMsg');
        throw FirebaseAuthException(message: errMsg, code: errorCode);
      });
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
      LoginUserData data = await getUserData();
      if (data.loginType != null) {
        switch (data.loginType) {
          case LoginType.KAKAO:
            loginClient = KakaoClient();
            break;
          case LoginType.GOOGLE:
            loginClient = GoogleClient();
            break;
          case LoginType.EMAIL:
            loginClient = EmailClient();
            break;
          default:
            print('로그아웃 실패');
            return false;
        }
        await loginClient?.logout();
      }
      return _firebaseAuth
          .signOut()
          .then((_) => removeUserData())
          .catchError((e) {
        print("logout  User Exception $e");
        return false;
      });
    } on Exception catch (e) {
      print('로그아웃 실패 :$e');
      return false;
    }
  }

  Future<bool> withdraw(String userId) async {
    bool reAuthResult = await _reAuthenticateUser(userId);

    if (reAuthResult) {
      return _firebaseAuth.currentUser
          .delete()
          .then((_) => removeAllDataToFireStore(userId: userId))
          .then((_) => removeUserData())
          .catchError((e) {
        var errorCode = e.code;
        var errMsg = e.message;
        print("회원탈퇴 오류 발생 :$errMsg 코드:$errorCode}");
        return false;
      });
    }
    return false;
  }

  _reAuthenticateUser(String userId) async {
    try {
      LoginUserData userData = await getUserItemFromFireStore(userId: userId);
      var credential = EmailAuthProvider.credential(
          email: userData.userId, password: userData.uniqueId);
      await _firebaseAuth.currentUser.reauthenticateWithCredential(credential);
      return true;
    } catch (e) {
      print("_reAuthenticateUser error :$e");
      return false;
    }
  }

  Future<RegisterStatus> register({LoginUserData userData}) async {
    try {
      String encryptId = userData.uniqueId.getEncryptString();

      LoginUserData registerData = userData.copyWith(
          uniqueId: encryptId,
          rankType: kBaseRankItem,
          isAutoScroll: true,
          homeItemCount: kBaseHomeItemCount);

      await _firebaseAuth.createUserWithEmailAndPassword(
          email: userData.userId, password: encryptId);
      await saveAllUserItemToFireStore(userData: registerData);
      await saveUserData(userData: registerData);
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
        await withdraw(userData.userId);
        return RegisterStatus.RegisterFailure;
      }
    } catch (e) {
      print("register Exception $e");
      await withdraw(userData.userId);
      return RegisterStatus.RegisterFailure;
    }
  }

  Future<LoginUserData> getUserItemFromFireStore({String userId}) async {
    try {
      DocumentSnapshot users =
          await firebaseFireStore.collection("users").doc(userId).get();
      if (users.data() != null) {
        LoginUserData userItem = LoginUserData.fromMap(users.data());
        return userItem;
      }
      return null;
    } catch (e) {
      print("getUserItemFromFireStore ${e}");
      return null;
    }
  }

  Future<bool> isSubscribe({String userId, String animationId}) async {
    try {
      DocumentSnapshot users =
          await firebaseFireStore.collection("subscribe").doc(userId).get();
      if (users.data() != null) {
        var subscribeIds = users.data()["animationIds"];
        if (subscribeIds != null) {
          return subscribeIds.any((id) => id == animationId);
        }
      }
      return false;
    } catch (e) {
      print("isSubscribe ${e}");
      return false;
    }
  }

  Future<bool> updateSubscribeAnimation(
      {String userId, String animationId, bool isSubscribe}) async {
    try {
      DocumentSnapshot users =
          await firebaseFireStore.collection("subscribe").doc(userId).get();
      if (users.data() != null) {
        List<String> subscribeIds =
            List.from(users.data()["animationIds"]) ?? [];
        if (!isSubscribe) {
          subscribeIds = subscribeIds..remove(animationId);
        } else {
          if (!subscribeIds.contains(animationId)) {
            subscribeIds = subscribeIds..add(animationId);
          }
        }
        await firebaseFireStore
            .collection("subscribe")
            .doc(userId)
            .update({"animationIds": subscribeIds});

      } else {
         await saveSubscribeItemToFireStore(animationId: animationId, userId: userId);
      }
      return isSubscribe;
    } catch (e) {
      print("subscribeAnimation ${e}");
      return false;
    }
  }

  Future<bool> removeUserDataToFireStore({String userId}) async {
    return firebaseFireStore
        .collection("users")
        .doc(userId)
        .delete()
        .then((value) => true)
        .catchError((e) {
      print("removeUserDataToFireStore error ${e}");
      return false;
    });
  }

  Future<bool> removeSubscribeDataToFireStore({String userId}) async {
    return firebaseFireStore
        .collection("subscribe")
        .doc(userId)
        .delete()
        .then((value) => true)
        .catchError((e) {
      print("removeSubscribeDataToFireStore error ${e}");
      return false;
    });
  }

  Future<bool> removeAllDataToFireStore({String userId}) async {
    try {
      bool removeSubscribeData = await removeSubscribeDataToFireStore(userId: userId);
      bool removeUserData = await removeUserDataToFireStore(userId: userId);
      return removeSubscribeData && removeUserData;
    } catch (e) {
      print("removeAllDataToFireStore error ${e}");
      return false;
    }
  }

  Future<bool> updateUserItemToFireStore({String userId, Map<String, dynamic> userItem}) async {
    return firebaseFireStore
        .collection("users")
        .doc(userId)
        .update(userItem)
        .then((_) => true)
        .onError((error, stackTrace) {
      print(error);
      return false;
    });
  }

  Future<bool> saveAllUserItemToFireStore({LoginUserData userData}) async =>
      firebaseFireStore
          .collection("users")
          .doc(userData.userId)
          .set(userData.toMap())
          .then((_) => true)
          .catchError((e) {
        print("saveAllUserItemToFireStore error :$e");
        return false;
      });

  saveSubscribeItemToFireStore({String userId, String animationId}) async =>
      firebaseFireStore
          .collection("subscribe")
          .doc(userId)
          .set({"animationIds": [animationId]})
          .then((value) => true)
          .catchError((e) {
            print("saveSubscribeItemToFireStore error :$e");
            return false;
          });
}
