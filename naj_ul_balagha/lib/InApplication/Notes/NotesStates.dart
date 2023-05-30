import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'NotesModel.dart';

abstract class NotesStates extends Equatable {
  const NotesStates();
}

class BlocInitial extends NotesStates {
  const BlocInitial();

  @override
  List<Object> get props => [];
}

class BlocMove extends NotesStates {
  const BlocMove();

  @override
  List<Object> get props => [];
}

class BlocLoad extends NotesStates {
  const BlocLoad();

  @override
  List<Object> get props => [];
}

class BlocSuccess extends NotesStates {
  final List<NotesModel> data;
  const BlocSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BlocError extends NotesStates {
  final String message;
  const BlocError(this.message);

  @override
  List<Object> get props => [message];
}
