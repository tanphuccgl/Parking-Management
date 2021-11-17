import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/user_history/data/data_source/user_history_remote.dart';
import 'package:parking_management1/feature/user_history/data/models/user_history_res.dart';
import 'package:parking_management1/feature/user_history/domain/repo/user_his_repo.dart';

class UserHistoryRepositoryImpl extends UserHistoryRepository {
  final NetworkInfo? networkInfo;
  final UserHistoryRemoteDataSource? courseContentsRemoteDataSource;

  UserHistoryRepositoryImpl({
    this.networkInfo,
    this.courseContentsRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserHistoryResponse>> courseContents(int id) {
    return _courseContents(courseContentsRemoteDataSource!.courseContents(id));
  }

  Future<Either<Failure, UserHistoryResponse>> _courseContents(
      Future<UserHistoryResponse> getContents) async {
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
