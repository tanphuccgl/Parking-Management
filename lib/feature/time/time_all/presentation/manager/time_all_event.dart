import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TimeAllEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TimeAllEventE extends TimeAllEvent {
  final String? loaixe;

  TimeAllEventE({this.loaixe});
}
