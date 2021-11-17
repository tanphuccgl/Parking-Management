import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/user_list/domain/repositories/user_get_vehicle_repo.dart';

class UserGetVahicle implements UseCase<UserGetVahicleResponse, int> {
  final UserGetVahicleRepository courseContentsRepository;

  UserGetVahicle(this.courseContentsRepository);

  @override
  Future<Either<Failure, UserGetVahicleResponse>> call(int id) async {
    return await courseContentsRepository.courseContents(id);
  }
}
