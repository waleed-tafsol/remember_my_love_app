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
        ? new CategoryModel.fromJson(json['category'])
        : null;
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    deliveryDate = json['deliveryDate'];
    isFavorite = json['isFavorite'];
    sendTo = json['sendTo'];
    if (json['recipients'] != null) {
      recipients = <Recipients>[];
      json['recipients'].forEach((v) {
        recipients!.add(new Recipients.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['description'] = this.description;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['deliveryDate'] = this.deliveryDate;
    data['isFavorite'] = this.isFavorite;
    data['sendTo'] = this.sendTo;
    if (this.recipients != null) {
      data['recipients'] = this.recipients?.map((v) {
        v != null ? v.toJson() : Recipients();
      }).toList();
    }
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
