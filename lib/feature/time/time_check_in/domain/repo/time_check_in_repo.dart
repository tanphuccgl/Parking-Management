import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/time/time_check_in/data/models/time_check_in_res.dart';

abstract class TimeCheckInRepository {
  Future<Either<Failure, TimeCheckInResponse>> getListTeacher();
}
