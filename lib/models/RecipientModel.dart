class Recipients {
  String? email;
  String? cc;
  String? country;
  String? contact;
  String? relation;
  String? sId;

  Recipients({this.email, this.contact, this.relation, this.sId});

  Recipients.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    cc = json['cc'];
    country = json['country'];
    contact = json['contact'];
    relation = json['relation'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['cc'] = cc;
    data['contact'] = contact;
    data['relation'] = relation;
    data['_id'] = sId;
    return data;
  }
}
