class Files {
  String? key;
  int? size;
  String? sId;

  Files({this.key, this.size, this.sId});

  Files.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    size = json['size'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['size'] = this.size;
    data['_id'] = this.sId;
    return data;
  }
}
