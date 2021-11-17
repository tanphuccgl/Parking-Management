import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/user_list/domain/usecase/user_get_vehicle.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_event.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_state.dart';

class UserGetVahicleBloc
    extends Bloc<UserGetVahicleEvent, UserGetVahicleState> {
  final UserGetVahicle courseGetContents;

  // final GetLocalProfile getLocalProfile;

  UserGetVahicleBloc({@required UserGetVahicle? pr})
      : assert(pr != null),
        courseGetContents = pr!,
        super(Empty());

  @override
  UserGetVahicleState get initialState => Empty();

  @override
  Stream<UserGetVahicleState> mapEventToState(
      UserGetVahicleEvent event) async* {
    if (event is UserGetVahicleE) {
      yield Loading();
      final failureOrSuccess = await courseGetContents(event.id!);
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<UserGetVahicleState> _eitherLoadedOrErrorState(
      Either<Failure, UserGetVahicleResponse> failureOrSuccess) async* {
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
