import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'BookmarksModel.dart';

abstract class BookmarkStates extends Equatable {
  const BookmarkStates();
}

class BookmarkBlocLoad extends BookmarkStates {
  const BookmarkBlocLoad();

  @override
  List<Object> get props => [];
}

class BookmarkBlocMove extends BookmarkStates {
  const BookmarkBlocMove();

  @override
  List<Object> get props => [];
}

class BookmarkBlocInitial extends BookmarkStates {
  const BookmarkBlocInitial();

  @override
  List<Object> get props => [];
}

class BookmarkBlocSuccess extends BookmarkStates {
  final List<BookmarksModel> data;
  const BookmarkBlocSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BookmarkBlocError extends BookmarkStates {
  final String message;
  const BookmarkBlocError(this.message);

  @override
  List<Object> get props => [message];
}
