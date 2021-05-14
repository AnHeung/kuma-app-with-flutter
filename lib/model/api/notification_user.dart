import 'package:flutter/cupertino.dart';

class NotificationData{

  final String episodeId;
  final String aired;
  final String title;
  final String videoUrl;

  const NotificationData({
    @required this.episodeId,
    @required this.aired,
    @required this.title,
    @required this.videoUrl,
  });

  NotificationData copyWith({
    String episodeId,
    String aired,
    String title,
    String videoUrl,
  }) {
    if ((episodeId == null || identical(episodeId, this.episodeId)) &&
        (aired == null || identical(aired, this.aired)) &&
        (title == null || identical(title, this.title)) &&
        (videoUrl == null || identical(videoUrl, this.videoUrl))) {
      return this;
    }

    return  NotificationData(
      episodeId: episodeId ?? this.episodeId,
      aired: aired ?? this.aired,
      title: title ?? this.title,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return  NotificationData(
      episodeId: map['episodeId'] as String,
      aired: map['aired'] as String,
      title: map['title'] as String,
      videoUrl: map['videoUrl'] as String,
    );
  }

}