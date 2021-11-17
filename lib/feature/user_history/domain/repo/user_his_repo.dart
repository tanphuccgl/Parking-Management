import 'package:dartz/dartz.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/user_history/data/models/user_history_res.dart';

abstract class UserHistoryRepository {
  Future<Either<Failure, UserHistoryResponse>> courseContents(int id);
}
