import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/time/time_check_out/data/models/time_check_out_res.dart';
import 'package:parking_management1/feature/time/time_check_out/domain/repo/time_check_out_repo.dart';

class GetTimeCheckOut implements UseCase<TimeCheckOutResponse, NoParams> {
  final TimeCheckOutRepository? listTeacherRepository;

  GetTimeCheckOut(this.listTeacherRepository);

  @override
  Future<Either<Failure, TimeCheckOutResponse>> call(NoParams params) async {
    return await listTeacherRepository!.getListTeacher();
  }
}
