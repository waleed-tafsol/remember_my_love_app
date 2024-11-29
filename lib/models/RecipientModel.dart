class Recipients {
  Recipient? recipient;
  String? email;
  String? contact;
  String? relation;
  String? sId;

  Recipients(
      {this.recipient, this.email, this.contact, this.relation, this.sId});

  Recipients.fromJson(Map<String, dynamic> json) {
    recipient = json['recipient'] != null
        ? new Recipient.fromJson(json['recipient'])
        : null;
    email = json['email'];
    contact = json['contact'];
    relation = json['relation'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recipient != null) {
      data['recipient'] = this.recipient!.toJson();
    }
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['relation'] = this.relation;
    data['_id'] = this.sId;
    return data;
  }
}

class Recipient {
  String? sId;
  String? name;
  String? username;
  String? email;
  String? photo;

  Recipient({this.sId, this.name, this.username, this.email, this.photo});

  Recipient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['photo'] = this.photo;
    return data;
  }
}
