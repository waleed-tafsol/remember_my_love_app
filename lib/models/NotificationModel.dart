
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
        payload!.add(Payload.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['senderMode'] = senderMode;
    data['flag'] = flag;
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    data['seen'] = seen;
    data['receiver'] = receiver;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    return data;
  }
}
