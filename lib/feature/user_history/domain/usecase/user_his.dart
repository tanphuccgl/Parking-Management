import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/user_history/data/models/user_history_res.dart';
import 'package:parking_management1/feature/user_history/domain/repo/user_his_repo.dart';

class UserHistory implements UseCase<UserHistoryResponse, int> {
  final UserHistoryRepository courseContentsRepository;

  UserHistory(this.courseContentsRepository);

  @override
  Future<Either<Failure, UserHistoryResponse>> call(int id) async {
    return await courseContentsRepository.courseContents(id);
  }
}
