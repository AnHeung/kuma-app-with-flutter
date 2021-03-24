import 'package:kuma_flutter_app/model/api/social_user.dart';

abstract class LoginClient {

  Future<LoginUserData> login();

  logout();

}