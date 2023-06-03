class HawashiModel {
  String? hawashi;

  HawashiModel({this.hawashi});

  HawashiModel.fromJson(Map<String, dynamic> json) {
    hawashi = json['hawashi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hawashi'] = hawashi;
    return data;
  }
}
