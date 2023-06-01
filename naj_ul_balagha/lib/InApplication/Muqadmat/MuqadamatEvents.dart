import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class MuqadamatEvent extends Equatable {
  const MuqadamatEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MuqadamatReadEvent extends MuqadamatEvent {
  final int Type;

  const MuqadamatReadEvent({required this.Type});

  @override
  List<Object?> get props => [];
}
