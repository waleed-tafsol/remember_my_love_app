class ConcernsItems {
  String? sId;
  String? name;
  bool? isActive;

  ConcernsItems(
      {this.sId,
        this.name,
        this.isActive,});

  ConcernsItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isActive = json['isActive'];
  }

}