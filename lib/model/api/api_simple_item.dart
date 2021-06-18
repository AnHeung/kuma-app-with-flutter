class ApiSimpleItem {

  bool err;
  String msg;

  ApiSimpleItem({this.err, this.msg});

  ApiSimpleItem.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['err'] = this.err;
    data['msg'] = this.msg;
    return data;
  }
}