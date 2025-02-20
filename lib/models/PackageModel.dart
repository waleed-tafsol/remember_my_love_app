class PackagesModel {
  String? sId;
  num? price;
  String? summary;
  String? title;
  String? packageType;
  String? packageId;
 // String? planId;
  String? recurringType;
  int? storage;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PackagesModel(
      {this.sId,
      this.price,
      this.summary,
      this.title,
      this.packageType,
      this.packageId,
     // this.planId,
      this.recurringType,
      this.storage,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PackagesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    price = json['price'];
    summary = json['summary'];
    title = json['title'];
    packageType = json['packageType'];
    packageId = json['packageId'];
   // planId = json['planId'];
    recurringType = json['recurringType'];
    storage = json['storage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['price'] = price;
    data['summary'] = summary;
    data['title'] = title;
    data['packageType'] = packageType;
    data['packageId'] = packageId;
    //data['planId'] = planId;
    data['recurringType'] = recurringType;
    data['storage'] = storage;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
