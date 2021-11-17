import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/login/data/models/login_response_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginData>> postLogin(String email, String pass);
  Future<Either<Failure, LoginData>> getCurrentUser();
}
