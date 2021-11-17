import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/time/time_check_out/data/models/time_check_out_res.dart';

abstract class TimeCheckOutRepository {
  Future<Either<Failure, TimeCheckOutResponse>> getListTeacher();
}
