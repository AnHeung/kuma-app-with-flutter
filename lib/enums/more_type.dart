import 'package:flutter/material.dart';

enum MoreType {Account  , Setting, VersionInfo, Logout}

extension  MoreTypeExtension on MoreType{

  get icon {

    switch(this){
      case MoreType.Account :
        return Icons.account_circle;
      case MoreType.VersionInfo :
        return Icons.info_outline;
      case MoreType.Setting :
        return Icons.settings;
      case MoreType.Logout :
        return Icons.logout;
    }
  }

  get title{

    switch(this){
      case MoreType.Account :
        return "계정 설정 ";
      case MoreType.Logout :
        return "로그아웃";
      case MoreType.VersionInfo :
        return "버전 정보";
      case MoreType.Setting :
        return "설정";
    }
  }
}