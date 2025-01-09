class MemoriesDatesModels {
  String? sId;
  String? status;
  DateTime? deliveryDate;

  MemoriesDatesModels({this.sId, this.status, this.deliveryDate});

  MemoriesDatesModels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    deliveryDate = DateTime.parse(json['deliveryDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['deliveryDate'] = this.deliveryDate;
    return data;
  }
}
