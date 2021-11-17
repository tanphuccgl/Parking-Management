import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/data/models/list_vahicle_in_park_res.dart';

@immutable
abstract class ListVahicleInParkState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends ListVahicleInParkState {}

class Loading extends ListVahicleInParkState {}

class Loaded extends ListVahicleInParkState {
  final ListVahicleInParkResponse? swagger;
  final List<Data>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends ListVahicleInParkState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
