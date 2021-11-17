import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/login/data/models/login_response_model.dart';
import 'package:parking_management1/feature/login/domain/repositories/login_repository.dart';

class GetCurrentUser implements UseCase<LoginData, NoParams> {
  final LoginRepository? loginRepository;

  GetCurrentUser({@required this.loginRepository});
  @override
  Future<Either<Failure, LoginData>> call(NoParams params) async {
    return await loginRepository!.getCurrentUser();
  }
}
