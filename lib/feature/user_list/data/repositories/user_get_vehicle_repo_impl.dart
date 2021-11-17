import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/user_list/data/data_source/user_get_vehicle_remote.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/user_list/domain/repositories/user_get_vehicle_repo.dart';

class UserGetVahicleRepositoryImpl extends UserGetVahicleRepository {
  final NetworkInfo? networkInfo;
  final UserGetVahicleRemoteDataSource? courseContentsRemoteDataSource;

  UserGetVahicleRepositoryImpl({
    this.networkInfo,
    this.courseContentsRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserGetVahicleResponse>> courseContents(int id) {
    return _courseContents(courseContentsRemoteDataSource!.courseContents(id));
  }

  Future<Either<Failure, UserGetVahicleResponse>> _courseContents(
      Future<UserGetVahicleResponse> getContents) async {
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
