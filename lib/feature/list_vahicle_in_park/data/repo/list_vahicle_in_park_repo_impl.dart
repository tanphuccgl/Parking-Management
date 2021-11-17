import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/data/data_source/list_vahicle_in_park_remote.dart';

import 'package:parking_management1/feature/list_vahicle_in_park/data/models/list_vahicle_in_park_res.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/domain/repo/list_vahicle_in_park_repo.dart';

class ListVahicleInParkRepositoryImpl extends ListVahicleInParkRepository {
  final NetworkInfo? networkInfo;
  final ListVahicleInParkRemoteDataSource? courseContentsRemoteDataSource;

  ListVahicleInParkRepositoryImpl({
    this.networkInfo,
    this.courseContentsRemoteDataSource,
  });

  @override
  Future<Either<Failure, ListVahicleInParkResponse>> courseContents(
      String loaixe, String name) {
    return _courseContents(
        courseContentsRemoteDataSource!.courseContents(loaixe, name));
  }

  Future<Either<Failure, ListVahicleInParkResponse>> _courseContents(
      Future<ListVahicleInParkResponse> getContents) async {
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
