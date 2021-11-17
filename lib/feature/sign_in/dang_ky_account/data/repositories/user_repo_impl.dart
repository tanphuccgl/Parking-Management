import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/data_source/account_remote.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/models/user_model.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/domain/repositories/user_repo.dart';

class GetUserRepositoryImpl extends GetUserRepository {
  final NetworkInfo? networkInfo;
  final GetUserRemoteDataSource? productRemoteDataSource;

  GetUserRepositoryImpl({
    this.networkInfo,
    this.productRemoteDataSource,
  });

  @override
  Future<Either<Failure, GetUser>> getProduct() {
    return _getProduct(productRemoteDataSource!.getProduct());
  }

  Future<Either<Failure, GetUser>> _getProduct(
      Future<GetUser> getProduct1) async {
    if (await networkInfo!.isConnected) {
      try {
        final product = await getProduct1;
        return Right(product);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
