class LoginResponseModel {
  String? message;
  LoginData? data;
  bool? success;
  int? status;

  LoginResponseModel({this.message, this.data, this.success, this.status});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class LoginData {
  int? iId;
  String? fullName;
  String? role;
  String? username;
  String? password;
  int? gender;
  bool? deleted;
  String? token;

  LoginData(
      {this.iId,
      this.fullName,
      this.role,
      this.username,
      this.password,
      this.gender,
      this.deleted,
      this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    fullName = json['fullName'];
    role = json['role'];
    username = json['username'];
    password = json['password'];
    gender = json['gender'];
    deleted = json['deleted'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['fullName'] = this.fullName;
    data['role'] = this.role;
    data['username'] = this.username;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['deleted'] = this.deleted;
    data['token'] = this.token;
    return data;
  }
}
