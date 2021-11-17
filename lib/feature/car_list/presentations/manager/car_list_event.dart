import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class VahicleListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VahicleListEventE extends VahicleListEvent {
  final String? loaixe;
  final String? name;

  VahicleListEventE({this.loaixe, this.name});
}
