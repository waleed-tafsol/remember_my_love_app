class RecipientsModel {
  String? email;
  String? contact;
  String? sId;

  RecipientsModel({this.email, this.contact, this.sId});

  RecipientsModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    contact = json['contact'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['_id'] = this.sId;
    return data;
  }
}
