import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'UserModel.dart';

abstract class StateBlock extends Equatable {
  const StateBlock();
}

class BlocInitial extends StateBlock {
  const BlocInitial();

  @override
  List<Object> get props => [];
}

class BlocLoad extends StateBlock {
  const BlocLoad();

  @override
  List<Object> get props => [];
}

class BlocSuccess extends StateBlock {
  final List<UserModel> data;
  const BlocSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BlocError extends StateBlock {
  final String message;
  const BlocError(this.message);

  @override
  List<Object> get props => [message];
}
