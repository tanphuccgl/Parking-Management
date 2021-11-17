import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/car_list/data/models/car_list_response_model.dart';
import 'package:parking_management1/feature/time/time_all/data/models/time_all_res.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';

abstract class TimeAllRepository {
  Future<Either<Failure, TimeAllResponse>> courseContents(String loaixe);
}
