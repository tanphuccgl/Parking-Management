import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/time/time_check_in/data/data_source/time_check_in_remote.dart';
import 'package:parking_management1/feature/time/time_check_in/data/models/time_check_in_res.dart';
import 'package:parking_management1/feature/time/time_check_in/domain/repo/time_check_in_repo.dart';

class TimeCheckInRepositoryImpl extends TimeCheckInRepository {
  final NetworkInfo? networkInfo;
  final TimeCheckInRemoteDataSource? listTeacherRemoteDataSource;

  TimeCheckInRepositoryImpl({
    this.networkInfo,
    this.listTeacherRemoteDataSource,
  });

  @override
  Future<Either<Failure, TimeCheckInResponse>> getListTeacher() {
    return _getListTeacher(listTeacherRemoteDataSource!.getListTeacher());
  }

  Future<Either<Failure, TimeCheckInResponse>> _getListTeacher(
      Future<TimeCheckInResponse> getProduct) async {
    if (await networkInfo!.isConnected) {
      try {
        final product = await getProduct;
        return Right(product);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
