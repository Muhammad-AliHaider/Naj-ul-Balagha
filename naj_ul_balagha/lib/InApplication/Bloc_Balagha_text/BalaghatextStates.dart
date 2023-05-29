import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'BalaghatextModel.dart';

abstract class textStateBloc extends Equatable {
  const textStateBloc();
}

class BlocLoad extends textStateBloc {
  const BlocLoad();

  @override
  List<Object> get props => [];
}

class BlocSuccess extends textStateBloc {
  final List<BalaghatextModel> data;
  const BlocSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BlocError extends textStateBloc {
  final String message;
  const BlocError(this.message);

  @override
  List<Object> get props => [message];
}
