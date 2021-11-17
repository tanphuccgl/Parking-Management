import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/car_list/data/data_source/car_list_remote.dart';
import 'package:parking_management1/feature/car_list/data/models/car_list_response_model.dart';
import 'package:parking_management1/feature/car_list/domain/repositories/car_list_repo.dart';
import 'package:parking_management1/feature/user_list/data/data_source/user_get_vehicle_remote.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/user_list/domain/repositories/user_get_vehicle_repo.dart';

class VahicleListRepositoryImpl extends VahicleListRepository {
  final NetworkInfo? networkInfo;
  final VahicleListRemoteDataSource? courseContentsRemoteDataSource;

  VahicleListRepositoryImpl({
    this.networkInfo,
    this.courseContentsRemoteDataSource,
  });

  @override
  Future<Either<Failure, VahicleListResponse>> courseContents(
      String loaixe, String name) {
    return _courseContents(
        courseContentsRemoteDataSource!.courseContents(loaixe, name));
  }

  Future<Either<Failure, VahicleListResponse>> _courseContents(
      Future<VahicleListResponse> getContents) async {
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
