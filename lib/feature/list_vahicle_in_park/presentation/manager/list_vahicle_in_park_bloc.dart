import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/data/models/list_vahicle_in_park_res.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/domain/usecase/list_vahicle_in_park.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/manager/list_vahicle_in_park_event.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/manager/list_vahicle_in_park_state.dart';

class ListVahicleInParkBloc
    extends Bloc<ListVahicleInParkEvent, ListVahicleInParkState> {
  final ListVahicleInPark courseGetContents;

  // final GetLocalProfile getLocalProfile;

  ListVahicleInParkBloc({@required ListVahicleInPark? pr})
      : assert(pr != null),
        courseGetContents = pr!,
        super(Empty());

  @override
  ListVahicleInParkState get initialState => Empty();

  @override
  Stream<ListVahicleInParkState> mapEventToState(
      ListVahicleInParkEvent event) async* {
    if (event is ListVahicleInParkEventE) {
      yield Loading();
      final failureOrSuccess = await courseGetContents(
          ListVahicleInParkParams(loaixe: event.loaixe, name: event.name));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<ListVahicleInParkState> _eitherLoadedOrErrorState(
      Either<Failure, ListVahicleInParkResponse> failureOrSuccess) async* {
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
