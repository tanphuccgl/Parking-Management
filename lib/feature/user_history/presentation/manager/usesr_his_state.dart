import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/feature/user_history/data/models/user_history_res.dart';

@immutable
abstract class UserHistoryState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends UserHistoryState {}

class Loading extends UserHistoryState {}

class Loaded extends UserHistoryState {
  final UserHistoryResponse? swagger;
  final List<Data>? data;

  Loaded({@required this.swagger, @required this.data});

  @override
  List<Object> get props => [swagger!];
}

class Error extends UserHistoryState {
  final String? message;

  Error({@required this.message});

  @override
  List<Object> get props => [message!];
}
