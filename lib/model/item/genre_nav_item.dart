import 'package:kuma_flutter_app/enums/category_click_status.dart';
import 'package:kuma_flutter_app/enums/genre_title.dart';

class GenreListItem{

  String type;
  String koreaType;
  List<GenreNavItem> navItems;

  GenreListItem({this.type,this.koreaType, this.navItems});

  GenreListItem copyWith({String type,  String koreaType, List<GenreNavItem> navItems}){
    return GenreListItem(type: type?? this.type , koreaType: koreaType ?? this.koreaType , navItems: navItems ?? this.navItems);
  }
}

class GenreNavItem{

  GenreType genreType;
  String category;
  String categoryValue;
  CategoryClickStatus clickStatus;

  GenreNavItem({this.genreType, this.category, this.categoryValue, clickStatus}) : this.clickStatus = clickStatus?? CategoryClickStatus.None;

  GenreNavItem copyWith({genreType, category, categoryValue, clickStatus}){
    return GenreNavItem(genreType: genreType ?? this.genreType , clickStatus: clickStatus ?? this.clickStatus , categoryValue: categoryValue ?? this.categoryValue ,category: category ?? this.category);
  }
}