import 'package:dio/dio.dart';

class BaseScrollItem {

  final String id;
  final String title;
  final String image;
  final String score;
  final VoidCallback onTap;

  BaseScrollItem({this.id, this.title, this.image, score,
     this.onTap}) : this.score = score ?? "";
}