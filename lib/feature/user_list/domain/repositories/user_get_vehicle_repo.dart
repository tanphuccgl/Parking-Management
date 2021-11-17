import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';

abstract class UserGetVahicleRepository {
  Future<Either<Failure, UserGetVahicleResponse>> courseContents(int id);
}
