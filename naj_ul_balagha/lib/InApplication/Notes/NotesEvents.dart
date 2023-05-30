import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

// String? title;
//   String? content;
//   String? uid;
//   String? id;

class NotesAddEvent extends NotesEvent {
  final String content;
  final String title;
  final String uid;

  const NotesAddEvent({
    required this.title,
    required this.content,
    required this.uid,
  });

  @override
  List<Object?> get props => [];
}

class NotesDeleteEvent extends NotesEvent {
  final String id;

  const NotesDeleteEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class readNotesEvent extends NotesEvent {
  final String id;

  const readNotesEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class readAllNotesEvent extends NotesEvent {
  final String uid;
  const readAllNotesEvent({required this.uid});

  @override
  List<Object?> get props => [];
}

class NotesUpdateEvent extends NotesEvent {
  final String content;
  final String title;
  final String uid;
  final String id;

  const NotesUpdateEvent({
    required this.title,
    required this.content,
    required this.uid,
    required this.id,
  });

  @override
  List<Object?> get props => [];
}
