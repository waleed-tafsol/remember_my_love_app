

class CmsModel {
  String? pageName;
  String? heroTitle;
  String? description;
  String? sId;
  String? createdAt;
  String? updatedAt;

  CmsModel(
      {this.pageName,
      this.heroTitle,
      this.description,
      this.sId,
      this.createdAt,
      this.updatedAt});

  CmsModel.fromJson(Map<String, dynamic> json) {
    pageName = json['pageName'];
    heroTitle = json['hero_title'];
    description = json['description'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageName'] = this.pageName;
    data['hero_title'] = this.heroTitle;
    data['description'] = this.description;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}