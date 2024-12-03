import 'package:remember_my_love_app/models/PackageModel.dart';

class UserModel {
  String? sId;
  String? name;
  String? username;
  String? email;
  String? contact;
  String? role;
  String? platform;
  String? status;
  bool? isOnline;
  String? photo;
  List<String>? fcmTokens;
  List<String>? socketIds;
  String? lastSeen;
  PackagesModel? package;
  String? subscription;
  String? validationKey;
  String? subscriptionStatus;
  String? subscriptionDueDate;
  String? subscriptionStartDate;
  num? availableStorage;
  bool? inAppNotifications;
  String? customerId;
  bool? pushNotifications;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserModel(
      {this.sId,
      this.name,
      this.username,
      this.email,
      this.contact,
      this.role,
      this.platform,
      this.status,
      this.isOnline,
      this.photo,
      this.fcmTokens,
      this.socketIds,
      this.lastSeen,
      this.package,
      this.subscription,
      this.validationKey,
      this.subscriptionStatus,
      this.subscriptionDueDate,
      this.subscriptionStartDate,
      this.availableStorage,
      this.inAppNotifications,
      this.customerId,
      this.pushNotifications,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    contact = json['contact'];
    role = json['role'];
    platform = json['platform'];
    status = json['status'];
    isOnline = json['isOnline'];
    photo = json['photo'];
    if (json['fcmTokens'] != null) {
      fcmTokens = <String>[];
      json['fcmTokens'].forEach((v) {
        fcmTokens!.add(v);
      });
    }
    if (json['socketIds'] != null) {
      socketIds = <String>[];
      json['socketIds'].forEach((v) {
        socketIds!.add(v);
      });
    }
    lastSeen = json['lastSeen'];
    package = json['package'] != null
        ? new PackagesModel.fromJson(json['package'])
        : null;
    subscription = json['subscription'];
    validationKey = json['validationKey'];
    subscriptionStatus = json['subscriptionStatus'];
    subscriptionDueDate = json['subscriptionDueDate'];
    subscriptionStartDate = json['subscriptionStartDate'];
    availableStorage = json['availableStorage'];
    inAppNotifications = json['inAppNotifications'];
    customerId = json['customerId'];
    pushNotifications = json['pushNotifications'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['role'] = this.role;
    data['platform'] = this.platform;
    data['status'] = this.status;
    data['isOnline'] = this.isOnline;
    data['photo'] = this.photo;
    if (this.fcmTokens != null) {
      data['fcmTokens'] = this.fcmTokens!.map((v) => v).toList();
    }
    if (this.socketIds != null) {
      data['socketIds'] = this.socketIds!.map((v) => v).toList();
    }
    data['lastSeen'] = this.lastSeen;
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    data['subscription'] = this.subscription;
    data['validationKey'] = this.validationKey;
    data['subscriptionStatus'] = this.subscriptionStatus;
    data['subscriptionDueDate'] = this.subscriptionDueDate;
    data['subscriptionStartDate'] = this.subscriptionStartDate;
    data['availableStorage'] = this.availableStorage;
    data['inAppNotifications'] = this.inAppNotifications;
    data['customerId'] = this.customerId;
    data['pushNotifications'] = this.pushNotifications;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
