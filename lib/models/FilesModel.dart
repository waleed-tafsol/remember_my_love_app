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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['size'] = size;
    data['_id'] = sId;
    return data;
  }
}
