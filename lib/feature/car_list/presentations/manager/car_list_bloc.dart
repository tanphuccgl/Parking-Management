import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/car_list/data/models/car_list_response_model.dart';
import 'package:parking_management1/feature/car_list/domain/usecase/car_list.dart';
import 'package:parking_management1/feature/car_list/presentations/manager/car_list_event.dart';
import 'package:parking_management1/feature/car_list/presentations/manager/car_list_state.dart';

class VahicleListBloc extends Bloc<VahicleListEvent, VahicleListState> {
  final VahicleList courseGetContents;

  // final GetLocalProfile getLocalProfile;

  VahicleListBloc({@required VahicleList? pr})
      : assert(pr != null),
        courseGetContents = pr!,
        super(Empty());

  @override
  VahicleListState get initialState => Empty();

  @override
  Stream<VahicleListState> mapEventToState(VahicleListEvent event) async* {
    if (event is VahicleListEventE) {
      yield Loading();
      final failureOrSuccess = await courseGetContents(
          Params(name: event.name, loaixe: event.loaixe));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<VahicleListState> _eitherLoadedOrErrorState(
      Either<Failure, VahicleListResponse> failureOrSuccess) async* {
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
