import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/login/data/data_sources/login_local_data_source.dart';
import 'package:parking_management1/feature/login/data/data_sources/login_remote_data_source.dart';
import 'package:parking_management1/feature/login/data/models/login_response_model.dart';
import 'package:parking_management1/feature/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfo networkInfo;
  final LoginLocalDataSource loginLocalDataSource;
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl(
      {required this.networkInfo,
      required this.loginLocalDataSource,
      required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, LoginData>> getCurrentUser() {
    return _getUser();
  }

  @override
  Future<Either<Failure, LoginData>> postLogin(String email, String pass) {
    return _login(loginRemoteDataSource.login(email, pass));
  }

  Future<Either<Failure, LoginData>> _getUser() async {
    try {
      final result = await loginLocalDataSource.getLogin();
      return Right(result);
    } on CacheException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginData>> _login(Future<LoginData> loginInfo) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await loginInfo;
        loginLocalDataSource.saveLogin(result);
        _getUser();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}