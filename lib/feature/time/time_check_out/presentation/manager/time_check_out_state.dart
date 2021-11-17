import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/feature/time/time_check_out/data/models/time_check_out_res.dart';

@immutable
abstract class TimeCheckOutState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends TimeCheckOutState {}

class Loading extends TimeCheckOutState {}

class Loaded extends TimeCheckOutState {
  final TimeCheckOutResponse? swagger;
  final List<Data>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends TimeCheckOutState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
