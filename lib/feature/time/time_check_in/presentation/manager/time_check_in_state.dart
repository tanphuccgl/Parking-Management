import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/feature/time/time_check_in/data/models/time_check_in_res.dart';

@immutable
abstract class TimeCheckInState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends TimeCheckInState {}

class Loading extends TimeCheckInState {}

class Loaded extends TimeCheckInState {
  final TimeCheckInResponse? swagger;
  final List<Data>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends TimeCheckInState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
