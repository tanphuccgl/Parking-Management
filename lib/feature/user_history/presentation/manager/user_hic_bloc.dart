import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/user_history/data/models/user_history_res.dart';
import 'package:parking_management1/feature/user_history/domain/usecase/user_his.dart';
import 'package:parking_management1/feature/user_history/presentation/manager/user_his_event.dart';
import 'package:parking_management1/feature/user_history/presentation/manager/usesr_his_state.dart';

class UserHistoryBloc extends Bloc<UserHistoryEvent, UserHistoryState> {
  final UserHistory courseGetContents;

  // final GetLocalProfile getLocalProfile;

  UserHistoryBloc({@required UserHistory? pr})
      : assert(pr != null),
        courseGetContents = pr!,
        super(Empty());

  @override
  UserHistoryState get initialState => Empty();

  @override
  Stream<UserHistoryState> mapEventToState(UserHistoryEvent event) async* {
    if (event is UserHistoryEventE) {
      yield Loading();
      final failureOrSuccess = await courseGetContents(event.id!);
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<UserHistoryState> _eitherLoadedOrErrorState(
      Either<Failure, UserHistoryResponse> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (res) => Loaded(swagger: res, data: res.data),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
