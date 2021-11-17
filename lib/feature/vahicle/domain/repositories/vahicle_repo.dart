import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/vahicle/data/models/vahicle_response_model.dart';

abstract class VahicleRepository {
  Future<Either<Failure, VahicleResponse>> courseContents(String id);
}
