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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['status'] = status;
    data['deliveryDate'] = deliveryDate;
    return data;
  }
}
