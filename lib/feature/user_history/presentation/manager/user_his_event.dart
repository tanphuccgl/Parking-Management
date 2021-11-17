import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserHistoryEventE extends UserHistoryEvent {
  final int? id;

  UserHistoryEventE({this.id});
}
