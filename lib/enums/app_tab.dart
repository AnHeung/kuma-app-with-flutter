import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kuma_flutter_app/app_constants.dart';

enum AppTab {Animation, Genre , News, More}

extension AppTabExtension on AppTab{
  String get title{
    switch (this) {
      case AppTab.Animation:
        return kAppTabAnimationTitle;
      case AppTab.Genre:
        return kAppTabGenreTitle;
      case AppTab.News:
        return kAppTabNewsTitle;
      case AppTab.More:
        return kAppTabMoreTitle;
      default:
        return kAppTabAnimationTitle;
    }
  }

  IconData get icon {
    IconData icon = Icons.terrain;

    switch (this) {
      case AppTab.Animation:
        icon = Icons.album;
        break;
      case AppTab.Genre:
        icon = Icons.phone_android_sharp;
        break;
      case AppTab.News:
        icon = Icons.update_sharp;
        break;
      case AppTab.More:
        icon = Icons.more_horiz;
        break;
    }
    return icon;
  }
}