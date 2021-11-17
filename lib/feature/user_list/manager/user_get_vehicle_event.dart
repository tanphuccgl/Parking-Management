import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserGetVahicleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserGetVahicleE extends UserGetVahicleEvent {
  final int? id;

  UserGetVahicleE({this.id});
}
