import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/time/time_check_in/data/models/time_check_in_res.dart';
import 'package:parking_management1/feature/time/time_check_in/domain/repo/time_check_in_repo.dart';

class GetTimeCheckIn implements UseCase<TimeCheckInResponse, NoParams> {
  final TimeCheckInRepository? listTeacherRepository;

  GetTimeCheckIn(this.listTeacherRepository);

  @override
  Future<Either<Failure, TimeCheckInResponse>> call(NoParams params) async {
    return await listTeacherRepository!.getListTeacher();
  }
}
