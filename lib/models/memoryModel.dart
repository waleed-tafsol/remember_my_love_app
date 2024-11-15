import 'package:remember_my_love_app/models/categories.dart';

class MemoryModel {
  String? sId;
  String? title;
  String? status;
  String? description;
  CategoryModel? category;
  CreatorModel? creator;
  String? deliveryDate;
  bool? isFavorite;
  String? sendTo;
  List<RecipientsModel>? recipients;
  String? recipientsRelation;
  List<FilesModel>? files;
  String? createdAt;
  String? updatedAt;
  String? month;
  String? year;

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
      this.recipientsRelation,
      this.files,
      this.createdAt,
      this.updatedAt,
      this.month,
      this.year});

  MemoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    description = json['description'];
    category = json['category'] != null
        ? new CategoryModel.fromJson(json['category'])
        : null;
    creator = json['creator'] != null
        ? new CreatorModel.fromJson(json['creator'])
        : null;
    deliveryDate = json['deliveryDate'];
    isFavorite = json['isFavorite'];
    sendTo = json['sendTo'];
    if (json['recipients'] != null) {
      recipients = <RecipientsModel>[];
      json['recipients'].forEach((v) {
        recipients!.add(new RecipientsModel.fromJson(v));
      });
    }
    recipientsRelation = json['recipientsRelation'];
    if (json['files'] != null) {
      files = <FilesModel>[];
      json['files'].forEach((v) {
        files!.add(new FilesModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    month = json['month'];
    year = json['year'];
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
      data['recipients'] = this.recipients!.map((v) => v.toJson()).toList();
    }
    data['recipientsRelation'] = this.recipientsRelation;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}

class CreatorModel {
  String? sId;
  String? name;
  String? email;
  String? status;
  String? photo;
  double? availableStorage;

  CreatorModel(
      {this.sId,
      this.name,
      this.email,
      this.status,
      this.photo,
      this.availableStorage});

  CreatorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    photo = json['photo'];
    availableStorage = json['availableStorage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['availableStorage'] = this.availableStorage;
    return data;
  }
}

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

class FilesModel {
  String? key;
  double? size;
  String? sId;

  FilesModel({this.key, this.size, this.sId});

  FilesModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    size = json['size'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['size'] = this.size;
    data['_id'] = this.sId;
    return data;
  }
}
