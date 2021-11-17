class TimeAllResponse {
  bool? success;
  int? statusCode;
  Meta? meta;
  List<Data>? data;

  TimeAllResponse({this.success, this.statusCode, this.meta, this.data});

  TimeAllResponse.fromJson(Map<String, dynamic> json) {
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
  int? employeeId;
  String? nameEmployee;
  String? typeVehicle;
  String? licensePlate;
  String? codeIn;
  String? dateIn;
  String? dateOut;
  bool? deleted;
  int? iV;

  Data(
      {this.iId,
      this.employeeId,
      this.nameEmployee,
      this.typeVehicle,
      this.licensePlate,
      this.codeIn,
      this.dateIn,
      this.dateOut,
      this.deleted,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    employeeId = json['employeeId'];
    nameEmployee = json['nameEmployee'];
    typeVehicle = json['typeVehicle'];
    licensePlate = json['licensePlate'];
    codeIn = json['codeIn'];
    dateIn = json['dateIn'];
    dateOut = json['dateOut'];
    deleted = json['deleted'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['employeeId'] = this.employeeId;
    data['nameEmployee'] = this.nameEmployee;
    data['typeVehicle'] = this.typeVehicle;
    data['licensePlate'] = this.licensePlate;
    data['codeIn'] = this.codeIn;
    data['dateIn'] = this.dateIn;
    data['dateOut'] = this.dateOut;
    data['deleted'] = this.deleted;
    data['__v'] = this.iV;
    return data;
  }
}
