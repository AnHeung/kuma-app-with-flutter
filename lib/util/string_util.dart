// Helper functions
import 'dart:convert';

import 'package:crypto/crypto.dart';

String enumToString(Object o) => o.toString().split('.').last;

T enumFromString<T>(String key, List<T> values) => values.firstWhere((v) => key == enumToString(v), orElse: () => null);

String getDayText(String day){
  switch(day){
    case "1" :
      return "월";
    case "2" :
      return "화";
    case "3" :
      return "수";
    case "4" :
      return "목";
    case "5" :
      return "금";
    case "6" :
      return "토";
    case "0" :
      return "일";
      default :
      return "월";
  }
}

String getDayToNum(String dayText){
  switch(dayText){
    case "월" :
      return "1";
    case "화" :
      return "2";
    case "수" :
      return "3";
    case "목" :
      return "4";
    case "금" :
      return "5";
    case "토" :
      return "6";
    case "일" :
      return "0";
    default :
      return "1";
  }
}


String getEncryptString({String uniqueId}){
  var bytes = utf8.encode(uniqueId);
  String encryptId = sha256.convert(bytes).toString() ?? uniqueId;
  return encryptId;
}