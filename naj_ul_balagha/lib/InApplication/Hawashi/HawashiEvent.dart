import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

@immutable
class HawashiEvent extends Equatable {
  const HawashiEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HawashiReadAllEvent extends HawashiEvent {
  const HawashiReadAllEvent();

  @override
  List<Object?> get props => [];
}
