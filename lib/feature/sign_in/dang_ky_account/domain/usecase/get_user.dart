import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/models/user_model.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/domain/repositories/user_repo.dart';

class GetProduct implements UseCase<GetUser, NoParams> {
  final GetUserRepository productRepository;

  GetProduct(this.productRepository);

  @override
  Future<Either<Failure, GetUser>> call(NoParams params) async {
    return await productRepository.getProduct();
  }
}
