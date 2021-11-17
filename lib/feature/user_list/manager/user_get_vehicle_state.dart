import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/user_list/domain/usecase/user_get_vehicle.dart';

@immutable
abstract class UserGetVahicleState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends UserGetVahicleState {}

class Loading extends UserGetVahicleState {}

class Loaded extends UserGetVahicleState {
  final UserGetVahicleResponse? swagger;
  final List<Message>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends UserGetVahicleState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
