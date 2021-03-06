class GetUser {
  bool? success;
  int? statusCode;
  Meta? meta;
  List<Data>? data;

  GetUser({this.success, this.statusCode, this.meta, this.data});

  GetUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? total;
  int? pageSize;
  int? pageNumber;

  Meta({this.total, this.pageSize, this.pageNumber});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['page_size'];
    pageNumber = json['page_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page_size'] = this.pageSize;
    data['page_number'] = this.pageNumber;
    return data;
  }
}

class Data {
  int? iId;
  String? fullName;
  String? role;
  String? username;
  String? password;
  int? gender;
  bool? deleted;

  Data(
      {this.iId,
      this.fullName,
      this.role,
      this.username,
      this.password,
      this.gender,
      this.deleted});

  Data.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    fullName = json['fullName'];
    role = json['role'];
    username = json['username'];
    password = json['password'];
    gender = json['gender'];
    deleted = json['deleted'];
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
    return data;
  }
}
