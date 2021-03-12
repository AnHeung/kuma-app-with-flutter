class SocialUserData{

 final String id;
 final  String email;

 const SocialUserData({this.id , this.email});

 static const empty = SocialUserData(email: '', id: '');

}