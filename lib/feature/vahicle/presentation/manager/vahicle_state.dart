import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/feature/vahicle/data/models/vahicle_response_model.dart';

@immutable
abstract class VahicleState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends VahicleState {}

class Loading extends VahicleState {}

class Loaded extends VahicleState {
  final VahicleResponse? swagger;
  final Message? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends VahicleState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
