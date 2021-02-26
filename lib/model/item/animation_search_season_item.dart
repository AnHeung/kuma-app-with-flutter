class AnimationSeasonItem {
  int id;
  String title;
  String image;

  AnimationSeasonItem({
    this.id,
    this.title,
    this.image,
  });

  AnimationSeasonItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}
