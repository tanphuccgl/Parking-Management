import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/failures.dart';

import 'package:parking_management1/feature/vahicle/data/models/vahicle_response_model.dart';
import 'package:parking_management1/feature/vahicle/domain/usecase/get_vahicle.dart';
import 'package:parking_management1/feature/vahicle/presentation/manager/vahicle_event.dart';
import 'package:parking_management1/feature/vahicle/presentation/manager/vahicle_state.dart';

class VahicleBloc extends Bloc<VahicleEvent, VahicleState> {
  final GetVahicle courseGetContents;

  // final GetLocalProfile getLocalProfile;

  VahicleBloc({@required GetVahicle? pr})
      : assert(pr != null),
        courseGetContents = pr!,
        super(Empty());

  @override
  VahicleState get initialState => Empty();

  @override
  Stream<VahicleState> mapEventToState(VahicleEvent event) async* {
    if (event is GetVahicleE) {
      yield Loading();
      final failureOrSuccess = await courseGetContents(event.id!);
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<VahicleState> _eitherLoadedOrErrorState(
      Either<Failure, VahicleResponse> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (res) => Loaded(swagger: res, data: res.message),
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
