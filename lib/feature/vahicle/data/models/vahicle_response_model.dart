class VahicleResponse {
  int? status;
  bool? success;
  Message? message;

  VahicleResponse({this.status, this.success, this.message});

  VahicleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  int? iId;
  int? employeeId;
  String? nameEmployee;
  String? typeVehicle;
  String? licensePlate;
  String? codeIn;
  String? qr;
  bool? deleted;
  int? iV;
  String? dateIn;
  String? dateOut;

  Message(
      {this.iId,
      this.employeeId,
      this.nameEmployee,
      this.typeVehicle,
      this.licensePlate,
      this.codeIn,
      this.qr,
      this.deleted,
      this.iV,
      this.dateIn,
      this.dateOut});

  Message.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    employeeId = json['employeeId'];
    nameEmployee = json['nameEmployee'];
    typeVehicle = json['typeVehicle'];
    licensePlate = json['licensePlate'];
    codeIn = json['codeIn'];
    qr = json['qr'];
    deleted = json['deleted'];
    dateIn = json['dateIn'];
    dateOut = json['dateOut'];
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
    data['qr'] = this.qr;
    data['deleted'] = this.deleted;
    data['__v'] = this.iV;
    data['dateIn'] = this.dateIn;
    data['dateOut'] = this.dateOut;
    return data;
  }
}
