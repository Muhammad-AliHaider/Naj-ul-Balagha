import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

@immutable
class textEvent extends Equatable {
  const textEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class textReadEvent extends textEvent {
  final int Type;
  final int TypeNo;

  const textReadEvent({required this.Type, required this.TypeNo});

  @override
  List<Object?> get props => [];
}
