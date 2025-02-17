class Creator {
  String? sId;
  String? name;
  String? email;
  String? status;
  String? photo;
  num? availableStorage;

  Creator(
      {this.sId,
      this.name,
      this.email,
      this.status,
      this.photo,
      this.availableStorage});

  Creator.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    photo = json['photo'];
    availableStorage = json['availableStorage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['status'] = status;
    data['photo'] = photo;
    data['availableStorage'] = availableStorage;
    return data;
  }
}
