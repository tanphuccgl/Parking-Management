import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/home/data/models/capacity_res.dart';
import 'package:parking_management1/feature/home/domain/repo/capacity_repo.dart';

class Capacity implements UseCase<CapacityResponse, String> {
  final CapacityRepository courseContentsRepository;

  Capacity(this.courseContentsRepository);

  @override
  Future<Either<Failure, CapacityResponse>> call(String loaixe) async {
    return await courseContentsRepository.courseContents(loaixe);
  }
}
