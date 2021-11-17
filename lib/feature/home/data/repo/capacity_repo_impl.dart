import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/home/data/data_source/capacity_remote.dart';
import 'package:parking_management1/feature/home/data/models/capacity_res.dart';
import 'package:parking_management1/feature/home/domain/repo/capacity_repo.dart';

class CapacityRepositoryImpl extends CapacityRepository {
  final NetworkInfo? networkInfo;
  final CapacityRemoteDataSource? courseContentsRemoteDataSource;

  CapacityRepositoryImpl({
    this.networkInfo,
    this.courseContentsRemoteDataSource,
  });

  @override
  Future<Either<Failure, CapacityResponse>> courseContents(String loaixe) {
    return _courseContents(
        courseContentsRemoteDataSource!.courseContents(loaixe));
  }

  Future<Either<Failure, CapacityResponse>> _courseContents(
      Future<CapacityResponse> getContents) async {
    if (await networkInfo!.isConnected) {
      try {
        final content = await getContents;
        return Right(content);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
