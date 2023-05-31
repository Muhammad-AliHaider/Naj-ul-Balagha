import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

@immutable
class BookmarksEvent extends Equatable {
  const BookmarksEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BookMarksReadAllEvent extends BookmarksEvent {
  final String uid;

  const BookMarksReadAllEvent({required this.uid});

  @override
  List<Object?> get props => [];
}

class AddBookmarksEvent extends BookmarksEvent {
  final int? typeNo;
  final int? typeid;
  final String? Description;
  final String? uid;
  final int? totaltypeNo;

  const AddBookmarksEvent(
      {required this.typeNo,
      required this.typeid,
      required this.Description,
      required this.uid,
      required this.totaltypeNo});

  @override
  List<Object?> get props => [];
}

class DeleteBookmarksEvent extends BookmarksEvent {
  final String? id;

  const DeleteBookmarksEvent({required this.id});

  @override
  List<Object?> get props => [];
}
