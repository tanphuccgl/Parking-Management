import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/user_list/domain/repositories/user_get_vehicle_repo.dart';
import 'package:parking_management1/feature/vahicle/data/models/vahicle_response_model.dart';
import 'package:parking_management1/feature/vahicle/domain/repositories/vahicle_repo.dart';

class GetVahicle implements UseCase<VahicleResponse, String> {
  final VahicleRepository courseContentsRepository;

  GetVahicle(this.courseContentsRepository);

  @override
  Future<Either<Failure, VahicleResponse>> call(String id) async {
    return await courseContentsRepository.courseContents(id);
  }
}
