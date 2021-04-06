import 'package:kuma_flutter_app/enums/category_click_status.dart';

class GenreSearchItemList{

  String type;
  List<GenreNavItem> navItems;

  GenreSearchItemList({this.type, this.navItems});
}

class GenreNavItem{

  String genreType;
  String category;
  String categoryValue;
  CategoryClickStatus clickStatus;

  GenreNavItem({this.genreType, this.category, this.categoryValue, clickStatus}) : this.clickStatus = clickStatus?? CategoryClickStatus.NONE;
}