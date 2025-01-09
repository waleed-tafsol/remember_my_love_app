import 'package:get/get.dart';

class NotificationModel {
  String? sId;
  String? senderMode;
  String? flag;
  String? message;
  List<Payload>? payload;
  String? title;
  bool? seen;
  String? receiver;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationModel(
      {this.sId,
      this.senderMode,
      this.flag,
      this.message,
      this.payload,
      this.title,
      this.seen,
      this.receiver,
      this.createdAt,
      this.updatedAt,
      this.iV});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderMode = json['senderMode'];
    flag = json['flag'];
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(new Payload.fromJson(v));
      });
    }
    title = json['title'];
    seen = json['seen'] ?? false;
    receiver = json['receiver'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['senderMode'] = this.senderMode;
    data['flag'] = this.flag;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['seen'] = this.seen;
    data['receiver'] = this.receiver;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Payload {
  String? id;

  Payload({this.id});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    return data;
  }
}
