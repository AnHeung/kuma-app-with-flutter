import 'package:kuma_flutter_app/model/api/social_user.dart';

abstract class SocialClient {

  Future<SocialUserData> login();

  logout();

}