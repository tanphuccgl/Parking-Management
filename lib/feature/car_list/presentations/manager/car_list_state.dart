import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/feature/car_list/data/models/car_list_response_model.dart';

@immutable
abstract class VahicleListState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends VahicleListState {}

class Loading extends VahicleListState {}

class Loaded extends VahicleListState {
  final VahicleListResponse? swagger;
  final List<Data>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends VahicleListState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
