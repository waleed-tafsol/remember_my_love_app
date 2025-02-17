class SearchUserModel {
  String? username;
  String? email;
  String? contact;

  SearchUserModel({
    this.username,
    this.email,
    this.contact,
  });

  SearchUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['username'] = username;
    data['email'] = email;
    data['contact'] = contact;

    return data;
  }
}
