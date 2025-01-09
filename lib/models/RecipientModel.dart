class Recipients {
  String? email;
  String? cc;
  String? contact;
  String? relation;
  String? sId;

  Recipients({this.email, this.contact, this.relation, this.sId});

  Recipients.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    cc = json['cc'];
    contact = json['contact'];
    relation = json['relation'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['cc'] = this.cc;
    data['contact'] = this.contact;
    data['relation'] = this.relation;
    data['_id'] = this.sId;
    return data;
  }
}
