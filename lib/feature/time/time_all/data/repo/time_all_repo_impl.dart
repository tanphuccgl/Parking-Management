import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/car_list/data/data_source/car_list_remote.dart';
import 'package:parking_management1/feature/car_list/data/models/car_list_response_model.dart';
import 'package:parking_management1/feature/car_list/domain/repositories/car_list_repo.dart';
import 'package:parking_management1/feature/time/time_all/data/data_source/time_all_remote.dart';
import 'package:parking_management1/feature/time/time_all/data/models/time_all_res.dart';
import 'package:parking_management1/feature/time/time_all/domain/repo/time_all_repo.dart';
import 'package:parking_management1/feature/user_list/data/data_source/user_get_vehicle_remote.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/user_list/domain/repositories/user_get_vehicle_repo.dart';

class TimeAllRepositoryImpl extends TimeAllRepository {
  final NetworkInfo? networkInfo;
  final TimeAllRemoteDataSource? courseContentsRemoteDataSource;

  TimeAllRepositoryImpl({
    this.networkInfo,
    this.courseContentsRemoteDataSource,
  });

  @override
  Future<Either<Failure, TimeAllResponse>> courseContents(String loaixe) {
    return _courseContents(
        courseContentsRemoteDataSource!.courseContents(loaixe));
  }

  Future<Either<Failure, TimeAllResponse>> _courseContents(
      Future<TimeAllResponse> getContents) async {
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
