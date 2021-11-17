import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/time/time_check_out/data/data_source/time_check_out_remote.dart';
import 'package:parking_management1/feature/time/time_check_out/data/models/time_check_out_res.dart';
import 'package:parking_management1/feature/time/time_check_out/domain/repo/time_check_out_repo.dart';

class TimeCheckOutRepositoryImpl extends TimeCheckOutRepository {
  final NetworkInfo? networkOutfo;
  final TimeCheckOutRemoteDataSource? listTeacherRemoteDataSource;

  TimeCheckOutRepositoryImpl({
    this.networkOutfo,
    this.listTeacherRemoteDataSource,
  });

  @override
  Future<Either<Failure, TimeCheckOutResponse>> getListTeacher() {
    return _getListTeacher(listTeacherRemoteDataSource!.getListTeacher());
  }

  Future<Either<Failure, TimeCheckOutResponse>> _getListTeacher(
      Future<TimeCheckOutResponse> getProduct) async {
    if (await networkOutfo!.isConnected) {
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
