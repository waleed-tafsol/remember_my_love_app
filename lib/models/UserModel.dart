import 'package:remember_my_love_app/models/PackageModel.dart';

class UserModel {
  String? sId;
  String? name;
  String? username;
  String? email;
  String? contact;
  String? cc;
  String? country;
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
  bool? ultimateStorage;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserModel(
      {this.sId,
      this.name,
      this.username,
      this.email,
      this.contact,
      this.cc,
      this.country,
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
      this.ultimateStorage,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    contact = json['contact'];
    cc = json['cc'];
    country = json['country'];
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
        ? PackagesModel.fromJson(json['package'])
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
    ultimateStorage = json['ultimateStorage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['contact'] = contact;
    data['cc'] = contact;
    data['country'] = country;
    data['role'] = role;
    data['platform'] = platform;
    data['status'] = status;
    data['isOnline'] = isOnline;
    data['photo'] = photo;
    if (fcmTokens != null) {
      data['fcmTokens'] = fcmTokens!.map((v) => v).toList();
    }
    if (socketIds != null) {
      data['socketIds'] = socketIds!.map((v) => v).toList();
    }
    data['lastSeen'] = lastSeen;
    if (package != null) {
      data['package'] = package!.toJson();
    }
    data['subscription'] = subscription;
    data['validationKey'] = validationKey;
    data['subscriptionStatus'] = subscriptionStatus;
    data['subscriptionDueDate'] = subscriptionDueDate;
    data['subscriptionStartDate'] = subscriptionStartDate;
    data['availableStorage'] = availableStorage;
    data['inAppNotifications'] = inAppNotifications;
    data['customerId'] = customerId;
    data['pushNotifications'] = pushNotifications;
    data['ultimateStorage'] = ultimateStorage;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
