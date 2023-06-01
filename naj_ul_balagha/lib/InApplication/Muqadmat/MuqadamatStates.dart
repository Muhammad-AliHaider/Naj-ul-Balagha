import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'MuqadamatModel.dart';

abstract class MuqadamatStates extends Equatable {
  const MuqadamatStates();
}

class BlocLoad extends MuqadamatStates {
  const BlocLoad();

  @override
  List<Object> get props => [];
}

class BlocSuccess extends MuqadamatStates {
  final List<MuqadamatModel> data;
  const BlocSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BlocError extends MuqadamatStates {
  final String message;
  const BlocError(this.message);

  @override
  List<Object> get props => [message];
}
