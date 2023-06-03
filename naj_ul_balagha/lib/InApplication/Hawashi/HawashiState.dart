import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import './HawashiModel.dart';

abstract class HawashiState extends Equatable {
  const HawashiState();
}

class BlocLoad extends HawashiState {
  const BlocLoad();

  @override
  List<Object> get props => [];
}

class BlocSuccess extends HawashiState {
  final List<HawashiModel> data;
  const BlocSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BlocError extends HawashiState {
  final String message;
  const BlocError(this.message);

  @override
  List<Object> get props => [message];
}
