// Helper functions
import 'dart:convert';

import 'package:crypto/crypto.dart';

T enumFromString<T>(String key, List<T> values) => values.firstWhere((v) => key == enumToString(v), orElse: () => null);

enumToString(Object o) => o.toString().split('.').last;

extension TextUtilsStringExtension on String {

  bool get isNullEmptyOrWhitespace => this == null || this.isEmpty || this.trim().isEmpty;

  getEncryptString(){
    var bytes = utf8.encode(this);
    String encryptId = sha256.convert(bytes).toString() ?? this;
    return encryptId;
  }

  getDayToNum(){
    switch(this){
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

  String getDayText(){
    switch(this){
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

}

extension GeneralUtilsObjectExtension on Object {

  bool get isNull => this == null;

  bool get isNotNull => this != null;

  bool get isNullOrEmpty =>
      isNull ||
          _isStringObjectEmpty ||
          _isIterableObjectEmpty ||
          _isMapObjectEmpty;

  bool get isNullEmptyOrFalse =>
      isNull ||
          _isStringObjectEmpty ||
          _isIterableObjectEmpty ||
          _isMapObjectEmpty ||
          _isBoolObjectFalse;

  bool get isNullEmptyFalseOrZero =>
      isNull ||
          _isStringObjectEmpty ||
          _isIterableObjectEmpty ||
          _isMapObjectEmpty ||
          _isBoolObjectFalse ||
          _isNumObjectZero;

  bool get _isStringObjectEmpty =>
      (this is String) ? (this as String).isEmpty : false;

  bool get _isIterableObjectEmpty =>
      (this is Iterable) ? (this as Iterable).isEmpty : false;

  bool get _isMapObjectEmpty => (this is Map) ? (this as Map).isEmpty : false;

  bool get _isBoolObjectFalse =>
      (this is bool) ? (this as bool) == false : false;

  bool get _isNumObjectZero => (this is num) ? (this as num) == 0 : false;
}