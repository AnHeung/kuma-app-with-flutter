class NotificationItem {

  final String title;
  final String userId;
  final String date;
  final String image;
  final String mainTitle;
  final String summary;
  final String thumbnail;

  const NotificationItem({
    this.title,
    this.userId,
    this.date,
    this.image,
    this.mainTitle,
    this.summary,
    this.thumbnail,
  });

  NotificationItem copyWith({
    String title,
    String userId,
    String date,
    String image,
    String mainTitle,
    String summary,
    String thumbnail,
  }) {
    return  NotificationItem(
      title: title ?? this.title,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      image: image ?? this.image,
      mainTitle: mainTitle ?? this.mainTitle,
      summary: summary ?? this.summary,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return  NotificationItem(
      title: map['title'] as String,
      userId: map['userId'] as String,
      date: map['date'] as String,
      image: map['image'] as String,
      mainTitle: map['mainTitle'] as String,
      summary: map['summary'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'userId': this.userId,
      'date': this.date,
      'image': this.image,
      'mainTitle': this.mainTitle,
      'summary': this.summary,
      'thumbnail': this.thumbnail,
    };
  }
}