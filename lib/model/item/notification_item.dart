class NotificationItem {

  final String id;
  final String title;
  final String userId;
  final String date;
  final bool isRead;
  final String url;
  final String image;
  final String mainTitle;
  final String summary;
  final String thumbnail;

  const NotificationItem({
    this.id,
    this.title,
    this.userId,
    this.date,
    this.isRead,
    this.url,
    this.image,
    this.mainTitle,
    this.summary,
    this.thumbnail,
  });

  NotificationItem copyWith({
    String id,
    String title,
    String userId,
    String date,
    bool isRead,
    String url,
    String image,
    String mainTitle,
    String summary,
    String thumbnail,
  }) {
    return  NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
      url: url ?? this.url,
      image: image ?? this.image,
      mainTitle: mainTitle ?? this.mainTitle,
      summary: summary ?? this.summary,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return  NotificationItem(
      id: map['_id'] as String,
      title: map['title'] as String,
      userId: map['userId'] as String,
      date: map['date'] as String,
      isRead: map['isRead'] as bool,
      url: map['url'] as String,
      image: map['image'] as String,
      mainTitle: map['mainTitle'] as String,
      summary: map['summary'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'userId': this.userId,
      'date': this.date,
      'isRead': this.isRead,
      'url': this.url,
      'image': this.image,
      'mainTitle': this.mainTitle,
      'summary': this.summary,
      'thumbnail': this.thumbnail,
    };
  }
}