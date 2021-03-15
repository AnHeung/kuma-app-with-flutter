import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';

class SocialUserData{

 final String uniqueId;
 final  String email;
 final String userName;
 final SocialType socialType;

 const SocialUserData({this.uniqueId , this.email, this.userName, this.socialType});

 static const empty = SocialUserData(email: '', uniqueId: '', userName: '', socialType:SocialType.UNKNOWN);

}