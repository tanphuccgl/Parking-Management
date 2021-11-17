import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/time/time_check_in/data/models/time_check_in_res.dart';
import 'package:parking_management1/feature/time/time_check_in/domain/usecase/get_time_check_in.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/manager/time_check_in_event.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/manager/time_check_in_state.dart';

class TimeCheckInBloc extends Bloc<TimeCheckInEvent, TimeCheckInState> {
  final GetTimeCheckIn? getListTeacher;

  TimeCheckInBloc({@required GetTimeCheckIn? pr})
      : assert(pr != null),
        getListTeacher = pr,
        super(Empty());

  TimeCheckInState get initialState => Empty();

  @override
  Stream<TimeCheckInState> mapEventToState(TimeCheckInEvent event) async* {
    if (event is TimeCheckInEventE) {
      yield Loading();
      final failureOrSuccess = await getListTeacher!(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<TimeCheckInState> _eitherLoadedOrErrorState(
      Either<Failure, TimeCheckInResponse> failureOrSuccess) async* {
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
