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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['availableStorage'] = this.availableStorage;
    return data;
  }
}
