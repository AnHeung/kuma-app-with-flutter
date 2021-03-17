import 'package:equatable/equatable.dart';

class SettingConfig{

  final bool isAutoScroll;
  final String aniLoadItemCount;
  final String rankingType;

  SettingConfig({this.isAutoScroll, this.aniLoadItemCount,this.rankingType});

  static final SettingConfig empty = SettingConfig(isAutoScroll: true, aniLoadItemCount: "30" ,rankingType :"all");

  SettingConfig copyWith({bool isAutoScroll ,String aniLoadItemCount ,String rankingType}){
    return SettingConfig(isAutoScroll:isAutoScroll ?? this.isAutoScroll , aniLoadItemCount: aniLoadItemCount ?? this.aniLoadItemCount , rankingType: rankingType?? this.rankingType );
  }
}