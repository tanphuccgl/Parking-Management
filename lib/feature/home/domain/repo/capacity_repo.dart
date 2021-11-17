import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/home/data/models/capacity_res.dart';

abstract class CapacityRepository {
  Future<Either<Failure, CapacityResponse>> courseContents(String loaixe);
}
