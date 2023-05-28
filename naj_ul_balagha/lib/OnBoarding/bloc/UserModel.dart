class UserModel {
  late String? Email;
  late String? Password;
  late String? UserName;
  late String? BirthDate;
  late String? uid;

  UserModel(
      {this.Email, this.Password, this.UserName, this.BirthDate, this.uid});

  void fromJson(Map<String, dynamic> json) {
    Email = json['Email'];
    Password = json['Password'];
    UserName = json['UserName'];
    BirthDate = json['BirthDate'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.Email;
    data['Password'] = this.Password;
    data['UserName'] = this.UserName;
    data['BirthDate'] = this.BirthDate;
    data['uid'] = this.uid;
    return data;
  }
}
