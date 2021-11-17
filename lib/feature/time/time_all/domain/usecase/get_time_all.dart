import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/car_list/data/models/car_list_response_model.dart';
import 'package:parking_management1/feature/car_list/domain/repositories/car_list_repo.dart';
import 'package:parking_management1/feature/time/time_all/data/models/time_all_res.dart';
import 'package:parking_management1/feature/time/time_all/domain/repo/time_all_repo.dart';

class GetTimeAll implements UseCase<TimeAllResponse, String> {
  final TimeAllRepository courseContentsRepository;

  GetTimeAll(this.courseContentsRepository);

  @override
  Future<Either<Failure, TimeAllResponse>> call(String loaixe) async {
    return await courseContentsRepository.courseContents(loaixe);
  }
}
