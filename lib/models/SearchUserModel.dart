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
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['username'] = this.username;
    data['email'] = this.email;
    data['contact'] = this.contact;

    return data;
  }
}
