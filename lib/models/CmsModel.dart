

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageName'] = pageName;
    data['hero_title'] = heroTitle;
    data['description'] = description;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}