import 'package:flutter/cupertino.dart';

class AnimationNewsItem {
  final String date;
  final String url;
  final String summary;
  final String title;
  final String imageUrl;

  const AnimationNewsItem({
    String date,
    String url,
    String summary,
    String title,
    String imageUrl,
  }) : this.date = date ?? "" , this.url = url ?? "" , this.summary = summary?? "", this.title = title ?? "", this.imageUrl = imageUrl ?? "";

  AnimationNewsItem copyWith({
    String date,
    String url,
    String summary,
    String title,
    String imageUrl,
  }) {
    if ((date == null || identical(date, this.date)) &&
        (url == null || identical(url, this.url)) &&
        (summary == null || identical(summary, this.summary)) &&
        (title == null || identical(title, this.title)) &&
        (imageUrl == null || identical(imageUrl, this.imageUrl))) {
      return this;
    }

    return AnimationNewsItem(
      date: date ?? this.date,
      url: url ?? this.url,
      summary: summary ?? this.summary,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'AnimationNewsItem{date: $date, url: $url, summary: $summary, title: $title, imageUrl: $imageUrl}';
  }

  factory AnimationNewsItem.fromMap(Map<String, dynamic> map) {
    return new AnimationNewsItem(
      date: map['date'] as String,
      url: map['url'] as String,
      summary: map['summary'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'url': this.url,
      'summary': this.summary,
      'title': this.title,
      'imageUrl': this.imageUrl,
    };
  }
}
