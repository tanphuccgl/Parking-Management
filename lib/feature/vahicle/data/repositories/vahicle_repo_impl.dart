import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/user_list/data/data_source/user_get_vehicle_remote.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/user_list/domain/repositories/user_get_vehicle_repo.dart';
import 'package:parking_management1/feature/vahicle/data/data_source/vahicle_remote.dart';
import 'package:parking_management1/feature/vahicle/data/models/vahicle_response_model.dart';
import 'package:parking_management1/feature/vahicle/domain/repositories/vahicle_repo.dart';

class VahicleRepositoryImpl extends VahicleRepository {
  final NetworkInfo? networkInfo;
  final VahicleRemoteDataSource? courseContentsRemoteDataSource;

  VahicleRepositoryImpl({
    this.networkInfo,
    this.courseContentsRemoteDataSource,
  });

  @override
  Future<Either<Failure, VahicleResponse>> courseContents(String id) {
    return _courseContents(courseContentsRemoteDataSource!.getProduct(id));
  }

  Future<Either<Failure, VahicleResponse>> _courseContents(
      Future<VahicleResponse> getContents) async {
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
