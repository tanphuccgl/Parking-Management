import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/home/data/models/capacity_res.dart';
import 'package:parking_management1/feature/home/domain/usecase/get_capacity.dart';
import 'package:parking_management1/feature/home/presentations/manager/capacity_event.dart';
import 'package:parking_management1/feature/home/presentations/manager/capacity_state.dart';

class CapacityBloc extends Bloc<CapacityEvent, CapacityState> {
  final Capacity courseGetContents;

  // final GetLocalProfile getLocalProfile;

  CapacityBloc({@required Capacity? pr})
      : assert(pr != null),
        courseGetContents = pr!,
        super(Empty());

  @override
  CapacityState get initialState => Empty();

  @override
  Stream<CapacityState> mapEventToState(CapacityEvent event) async* {
    if (event is CapacityEventE) {
      yield Loading();
      final failureOrSuccess = await courseGetContents(event.loaixe!);
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    } else if (event is CapacityEvent1E) {
      yield Loading();
      final failureOrSuccess = await courseGetContents(event.loaixe!);
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<CapacityState> _eitherLoadedOrErrorState(
      Either<Failure, CapacityResponse> failureOrSuccess) async* {
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
