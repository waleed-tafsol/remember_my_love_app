class CatagoriesModel {
  String? sId;
  String? name;
  bool? isActive;

  CatagoriesModel({this.sId, this.name, this.isActive});

  CatagoriesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    return data;
  }
}
