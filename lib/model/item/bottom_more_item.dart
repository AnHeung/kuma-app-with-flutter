class BottomMoreItem {

  final String id;
  final String imgUrl;
  final String title;

  const BottomMoreItem({this.id, this.imgUrl, this.title});

  BottomMoreItem copyWith({String id, String imgUrl, String title})=>BottomMoreItem(title: title ?? this.title , id: id ?? this.id , imgUrl: imgUrl?? this.imgUrl);

}