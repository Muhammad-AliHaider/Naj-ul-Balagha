class BookmarksModel {
  int? typeNo;
  int? typeid;
  String? Description;
  String? uid;
  String? id;
  int? totaltypeNo;

  BookmarksModel(
      {this.typeNo, this.typeid, this.Description, this.uid, this.totaltypeNo});

  void fromJson(Map<String, dynamic> json) {
    typeNo = json['typeNo'];
    typeid = json['typeid'];
    Description = json['description'];
    uid = json['uid'];
    totaltypeNo = json['totaltypeNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeNo'] = this.typeNo;
    data['typeid'] = this.typeid;
    data['description'] = this.Description;
    data['uid'] = this.uid;
    data['totaltypeNo'] = this.totaltypeNo;

    return data;
  }
}
