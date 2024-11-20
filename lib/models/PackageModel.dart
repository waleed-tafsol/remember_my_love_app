class PackageModel {
  String? sId;
  num? price;
  String? summary;
  String? title;
  String? packageType;
  String? packageId;
  String? planId;
  String? recurringType;
  int? storage;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PackageModel(
      {this.sId,
      this.price,
      this.summary,
      this.title,
      this.packageType,
      this.packageId,
      this.planId,
      this.recurringType,
      this.storage,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PackageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    price = json['price'];
    summary = json['summary'];
    title = json['title'];
    packageType = json['packageType'];
    packageId = json['packageId'];
    planId = json['planId'];
    recurringType = json['recurringType'];
    storage = json['storage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['price'] = this.price;
    data['summary'] = this.summary;
    data['title'] = this.title;
    data['packageType'] = this.packageType;
    data['packageId'] = this.packageId;
    data['planId'] = this.planId;
    data['recurringType'] = this.recurringType;
    data['storage'] = this.storage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
