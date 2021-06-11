class SubscribeItem {

  final String title;
  final String animationId;
  final String img;

  const SubscribeItem({this.title, this.animationId, this.img});

  factory SubscribeItem.fromMap(Map<String, dynamic> map) {
    return SubscribeItem(
      title: map['title'] as String,
      animationId: map['animationId'] as String,
      img: map['img'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'animationId': this.animationId,
      'img': this.img,
    };
  }
}