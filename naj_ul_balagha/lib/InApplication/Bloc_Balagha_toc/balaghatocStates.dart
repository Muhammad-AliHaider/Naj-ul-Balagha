import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'balaghatocModel.dart';

abstract class tocStateBloc extends Equatable {
  const tocStateBloc();
}

class BlocLoad extends tocStateBloc {
  const BlocLoad();

  @override
  List<Object> get props => [];
}

class BlocSuccess extends tocStateBloc {
  final List<BalaghatocModel> data;
  const BlocSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BlocError extends tocStateBloc {
  final String message;
  const BlocError(this.message);

  @override
  List<Object> get props => [message];
}
