import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ListVahicleInParkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListVahicleInParkEventE extends ListVahicleInParkEvent {
  final String? loaixe;
  final String? name;

  ListVahicleInParkEventE({this.loaixe, this.name});
}
