import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CapacityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CapacityEventE extends CapacityEvent {
  final String? loaixe;

  CapacityEventE({this.loaixe});
}

class CapacityEvent1E extends CapacityEvent {
  final String? loaixe;

  CapacityEvent1E({this.loaixe});
}
