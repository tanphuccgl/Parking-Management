import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class VahicleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetVahicleE extends VahicleEvent {
  final String? id;

  GetVahicleE({this.id});
}
