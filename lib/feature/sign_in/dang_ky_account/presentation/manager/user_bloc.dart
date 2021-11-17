import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/models/user_model.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/domain/usecase/get_user.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/manager/user_event.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/manager/user_state.dart';

class ProductBloc extends Bloc<UserEvent, UserState> {
  final GetProduct? getProduct;

  // final GetLocalProfile getLocalProfile;

  ProductBloc({GetProduct? pr})
      : assert(pr != null),
        getProduct = pr,
        super(Empty());

  @override
  UserState get initialState => Empty();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUserE) {
      yield Loading();
      final failureOrSuccess = await getProduct!(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
      print(failureOrSuccess);
    }
  }

  Stream<UserState> _eitherLoadedOrErrorState(
      Either<Failure, GetUser> failureOrSuccess) async* {
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
