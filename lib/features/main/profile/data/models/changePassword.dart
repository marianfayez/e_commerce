class ChangePasswordModel {
  ChangePasswordModel({
      this.currentPassword, 
      this.password, 
      this.rePassword,});

  ChangePasswordModel.fromJson(dynamic json) {
    currentPassword = json['currentPassword'];
    password = json['password'];
    rePassword = json['rePassword'];
  }
  String? currentPassword;
  String? password;
  String? rePassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPassword'] = currentPassword;
    map['password'] = password;
    map['rePassword'] = rePassword;
    return map;
  }

}