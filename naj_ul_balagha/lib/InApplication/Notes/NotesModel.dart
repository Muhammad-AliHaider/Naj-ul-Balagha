class NotesModel {
  String? title;
  String? content;
  String? uid;
  String? id;

  NotesModel({this.title, this.content, this.uid});

  void fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    id = json['id'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['id'] = this.id;
    data['uid'] = this.uid;
    return data;
  }
}
