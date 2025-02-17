import 'CreatorModel.dart';
import 'RecipientModel.dart';
import 'Categories.dart';

class MemoryModel {
  String? sId;
  String? title;
  String? status;
  String? description;
  CategoryModel? category;
  Creator? creator;
  String? deliveryDate;
  bool? isFavorite;
  String? sendTo;
  List<Recipients?>? recipients;
  List<String>? files;
  String? createdAt;
  String? adjustedDeliveryDate;
  String? updatedAt;

  MemoryModel(
      {this.sId,
      this.title,
      this.status,
      this.description,
      this.category,
      this.creator,
      this.deliveryDate,
      this.isFavorite,
      this.sendTo,
      this.recipients,
      this.files,
      this.createdAt,
      this.adjustedDeliveryDate,
      this.updatedAt});

  MemoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    description = json['description'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    deliveryDate = json['deliveryDate'];
    isFavorite = json['isFavorite'];
    sendTo = json['sendTo'];
    if (json['recipients'] != null) {
      recipients = <Recipients>[];
      json['recipients'].forEach((v) {
        recipients!.add(Recipients.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <String>[];
      json['files'].forEach((v) {
        files!.add(v);
      });
    }
    createdAt = json['createdAt'];
    adjustedDeliveryDate = json['adjustedDeliveryDate'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['status'] = status;
    data['description'] = description;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    data['deliveryDate'] = deliveryDate;
    data['isFavorite'] = isFavorite;
    data['sendTo'] = sendTo;
    if (recipients != null) {
      data['recipients'] = recipients?.map((v) {
        v != null ? v.toJson() : Recipients();
      }).toList();
    }
    if (files != null) {
      data['files'] = files!.map((v) => v).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
