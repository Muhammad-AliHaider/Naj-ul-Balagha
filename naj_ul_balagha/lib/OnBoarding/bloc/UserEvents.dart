import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class user_Event extends Equatable {
  const user_Event();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class userAdd_Event extends user_Event {
  final String Email;
  final String Password;
  final String UserName;
  final String BirthDate;
  final String uid;

  const userAdd_Event({
    required this.Email,
    required this.Password,
    required this.UserName,
    required this.BirthDate,
    required this.uid,
  });

  @override
  List<Object?> get props => [];
}

class userDelete_Event extends user_Event {
  final String uid;

  const userDelete_Event({required this.uid});

  @override
  List<Object?> get props => [];
}

class readUser_Event extends user_Event {
  final String uid;

  const readUser_Event({required this.uid});

  @override
  List<Object?> get props => [];
}

class readAllUser_Event extends user_Event {
  const readAllUser_Event();

  @override
  List<Object?> get props => [];
}

class userUpdate_Event extends user_Event {
  final String Email;
  final String Password;
  final String UserName;
  final String BirthDate;
  final String id;

  const userUpdate_Event({
    required this.Email,
    required this.Password,
    required this.UserName,
    required this.BirthDate,
    required this.id,
  });

  @override
  List<Object?> get props => [];
}
