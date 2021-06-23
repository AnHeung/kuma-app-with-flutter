part of 'common.dart';

validateEmail (String email)=>RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email) ? null :  "이메일을 형식에 맞게 입력해주세요";

validateUserPw (String pw)=>RegExp(r"^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(pw) ? null :  "비밀번호를 맞게 써주세요(최소8자 특수문자 하나 포함)";

getVideoId(String url){
  final RegExp regex = RegExp(r'.*(?:(?:youtu\.be/|v/|vi/|u/\w/|embed/)|(?:(?:watch)?\?v(?:i)?=|&v(?:i)?=))([^#&?]*).*', caseSensitive: false, multiLine: false,);
  if (regex.hasMatch(url)) {
    final videoId = regex.firstMatch(url).group(1);
    print("videoId ${videoId}");
    return videoId;
  } else {
    print("Cannot parse $url");
  }
  return "";
}