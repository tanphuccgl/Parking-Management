import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/time/time_all/data/models/time_all_res.dart';
import 'package:parking_management1/feature/time/time_all/domain/usecase/get_time_all.dart';
import 'package:parking_management1/feature/time/time_all/presentation/manager/time_all_event.dart';
import 'package:parking_management1/feature/time/time_all/presentation/manager/time_all_state.dart';

class TimeAllBloc extends Bloc<TimeAllEvent, TimeAllState> {
  final GetTimeAll courseGetContents;

  // final GetLocalProfile getLocalProfile;

  TimeAllBloc({@required GetTimeAll? pr})
      : assert(pr != null),
        courseGetContents = pr!,
        super(Empty());

  @override
  TimeAllState get initialState => Empty();

  @override
  Stream<TimeAllState> mapEventToState(TimeAllEvent event) async* {
    if (event is TimeAllEventE) {
      yield Loading();
      final failureOrSuccess = await courseGetContents(event.loaixe!);
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<TimeAllState> _eitherLoadedOrErrorState(
      Either<Failure, TimeAllResponse> failureOrSuccess) async* {
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
