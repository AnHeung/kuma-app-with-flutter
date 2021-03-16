import 'package:flutter/material.dart';

enum MoreType {Account , Notification , Logout , VersionInfo, Setting}

extension  MoreTypeExtension on MoreType{

  get icon {

    switch(this){
      case MoreType.Account :
        return Icons.account_circle;
      case MoreType.Notification :
        return Icons.notifications_none;
      case MoreType.Logout :
        return Icons.logout;
      case MoreType.VersionInfo :
        return Icons.info_outline;
      case MoreType.Setting :
        return Icons.settings;
    }
  }

  get title{

    switch(this){
      case MoreType.Account :
        return "계정 설정 ";
      case MoreType.Notification :
        return "알림 설정";
      case MoreType.Logout :
        return "로그아웃";
      case MoreType.VersionInfo :
        return "버전 정보";
      case MoreType.Setting :
        return "설정";
    }
  }
}