import 'PackageModel.dart';

class UserModel {
  String? sId;
  String? name;
  String? email;
  String? contact;
  String? role;
  String? status;
  bool? isOnline;
  String? photo;
  List<String>? fcmTokens;
  List<String>? socketIds;
  String? lastSeen;
  PackageModel? package;
  String? subscription;
  String? subscriptionStatus;
  String? subscriptionDueDate;
  String? subscriptionStartDate;
  bool? inAppNotifications;
  String? customerId;
  bool? pushNotifications;
  String? createdAt;
  String? updatedAt;
  int? iV;
  num? availableStorage;
  String? username;

  UserModel(
      {this.sId,
      this.name,
      this.email,
      this.contact,
      this.role,
      this.status,
      this.isOnline,
      this.photo,
      this.fcmTokens,
      this.socketIds,
      this.lastSeen,
      this.package,
      this.subscription,
      this.subscriptionStatus,
      this.subscriptionDueDate,
      this.subscriptionStartDate,
      this.inAppNotifications,
      this.customerId,
      this.pushNotifications,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.availableStorage,
      this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    role = json['role'];
    status = json['status'];
    isOnline = json['isOnline'];
    photo = json['photo'];
    if (json['fcmTokens'] != null) {
      fcmTokens = <String>[];
      json['fcmTokens'];
    }
    if (json['socketIds'] != null) {
      socketIds = <String>[];
      json['socketIds'];
    }
    lastSeen = json['lastSeen'];
    package = json['package'] != null
        ? new PackageModel.fromJson(json['package'])
        : null;
    subscription = json['subscription'];
    subscriptionStatus = json['subscriptionStatus'];
    subscriptionDueDate = json['subscriptionDueDate'];
    subscriptionStartDate = json['subscriptionStartDate'];
    inAppNotifications = json['inAppNotifications'];
    customerId = json['customerId'];
    pushNotifications = json['pushNotifications'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    availableStorage = json['availableStorage'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['role'] = this.role;
    data['status'] = this.status;
    data['isOnline'] = this.isOnline;
    data['photo'] = this.photo;
    if (this.fcmTokens != null) {
      data['fcmTokens'] = this.fcmTokens;
    }
    if (this.socketIds != null) {
      data['socketIds'] = this.socketIds;
    }
    data['lastSeen'] = this.lastSeen;
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    data['subscription'] = this.subscription;
    data['subscriptionStatus'] = this.subscriptionStatus;
    data['subscriptionDueDate'] = this.subscriptionDueDate;
    data['subscriptionStartDate'] = this.subscriptionStartDate;
    data['inAppNotifications'] = this.inAppNotifications;
    data['customerId'] = this.customerId;
    data['pushNotifications'] = this.pushNotifications;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['availableStorage'] = this.availableStorage;
    data['username'] = this.username;
    return data;
  }
}
