class SubscribeItem {

  final String mainTitle;
  final String animationId;
  final String thumbnail;

  const SubscribeItem({this.mainTitle, this.animationId, this.thumbnail});

  factory SubscribeItem.fromMap(Map<String, dynamic> map) {
    return SubscribeItem(
      mainTitle: map['mainTitle'] as String,
      animationId: map['animationId'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mainTitle': this.mainTitle,
      'animationId': this.animationId,
      'thumbnail': this.thumbnail,
    };
  }
}