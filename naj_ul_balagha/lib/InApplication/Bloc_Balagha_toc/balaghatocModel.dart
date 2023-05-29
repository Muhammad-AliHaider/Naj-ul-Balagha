class BalaghatocModel {
  int? typeNo;
  int? typeid;
  String? Description;
  int? id;

  BalaghatocModel({this.typeNo, this.typeid, this.Description});

  void fromJson(Map<String, dynamic> json) {
    typeNo = json['typeNo'];
    typeid = json['typeid'];
    Description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeNo'] = this.typeNo;
    data['typeid'] = this.typeid;
    data['description'] = this.Description;
    data['id'] = this.id;
    return data;
  }
}
