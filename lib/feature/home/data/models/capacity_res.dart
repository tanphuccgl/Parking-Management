class CapacityResponse {
  int? status;
  bool? success;
  String? message;
  Data? data;

  CapacityResponse({this.status, this.success, this.message, this.data});

  CapacityResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? typeVehicle;
  int? nowVehicle;
  int? capacity;

  Data({this.typeVehicle, this.nowVehicle, this.capacity});

  Data.fromJson(Map<String, dynamic> json) {
    typeVehicle = json['typeVehicle'];
    nowVehicle = json['nowVehicle'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeVehicle'] = this.typeVehicle;
    data['nowVehicle'] = this.nowVehicle;
    data['capacity'] = this.capacity;
    return data;
  }
}
