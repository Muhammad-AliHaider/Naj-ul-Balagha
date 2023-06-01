class MuqadamatModel {
  String? mqar;
  String? mqur;
  int? type;
  int? id;

  MuqadamatModel({this.mqar, this.mqur, this.type, this.id});

  void fromJson(Map<String, dynamic> json) {
    mqar = json['mqar'];
    mqur = json['mqur'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mqar'] = mqar;
    data['mqur'] = mqur;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}
