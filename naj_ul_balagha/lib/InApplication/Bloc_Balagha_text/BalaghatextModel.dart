class BalaghatextModel {
  int? id;
  int? type;
  int? typeNo;
  String? AR;
  String? UR;
  String? ARsimple;

  BalaghatextModel(
      {this.id, this.type, this.typeNo, this.AR, this.UR, this.ARsimple});

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    typeNo = json['typeNo'];
    AR = json['AR'];
    UR = json['UR'];
    ARsimple = json['ARSIMPLE'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['typeNo'] = typeNo;
    data['AR'] = AR;
    data['UR'] = UR;
    data['ARSIMPLE'] = ARsimple;
    return data;
  }
}
