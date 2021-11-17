import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/time/time_check_out/data/models/time_check_out_res.dart';
import 'package:parking_management1/feature/time/time_check_out/domain/usecase/time_check_out.dart';
import 'package:parking_management1/feature/time/time_check_out/presentation/manager/time_check_out_event.dart';
import 'package:parking_management1/feature/time/time_check_out/presentation/manager/time_check_out_state.dart';

class TimeCheckOutBloc extends Bloc<TimeCheckOutEvent, TimeCheckOutState> {
  final GetTimeCheckOut? getListTeacher;

  TimeCheckOutBloc({@required GetTimeCheckOut? pr})
      : assert(pr != null),
        getListTeacher = pr,
        super(Empty());

  TimeCheckOutState get OutitialState => Empty();

  @override
  Stream<TimeCheckOutState> mapEventToState(TimeCheckOutEvent event) async* {
    if (event is TimeCheckOutEventE) {
      yield Loading();
      final failureOrSuccess = await getListTeacher!(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<TimeCheckOutState> _eitherLoadedOrErrorState(
      Either<Failure, TimeCheckOutResponse> failureOrSuccess) async* {
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
