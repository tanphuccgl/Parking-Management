import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/models/user_model.dart';

abstract class GetUserRepository {
  Future<Either<Failure, GetUser>> getProduct();
}
