import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/feature/home/data/models/capacity_res.dart';

@immutable
abstract class CapacityState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends CapacityState {}

class Loading extends CapacityState {}

class Loaded extends CapacityState {
  final CapacityResponse? swagger;
  final Data? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends CapacityState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
