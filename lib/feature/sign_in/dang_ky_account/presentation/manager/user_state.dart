import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/models/user_model.dart';

@immutable
abstract class UserState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends UserState {}

class Loading extends UserState {}

class Loaded extends UserState {
  final GetUser? swagger;
  final List<Data>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends UserState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
