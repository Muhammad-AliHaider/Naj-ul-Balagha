import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

@immutable
class tocEvent extends Equatable {
  const tocEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class tocReadEvent extends tocEvent {
  final int TypeId;

  const tocReadEvent({required this.TypeId});

  @override
  List<Object?> get props => [];
}
