import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/feature/time/time_all/data/models/time_all_res.dart';

@immutable
abstract class TimeAllState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends TimeAllState {}

class Loading extends TimeAllState {}

class Loaded extends TimeAllState {
  final TimeAllResponse? swagger;
  final List<Data>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends TimeAllState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
