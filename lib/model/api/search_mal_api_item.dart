import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SearchMalSimpleApiItem {
  int id;
  String title;
  String image;
  String startDate;

  SearchMalSimpleApiItem({this.id, this.title, this.image, this.startDate});

  SearchMalSimpleApiItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['start_date'] = this.startDate;
    return data;
  }
}
