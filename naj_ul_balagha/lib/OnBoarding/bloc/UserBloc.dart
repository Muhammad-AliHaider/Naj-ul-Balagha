import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/SignUp/UserModel.dart';
// import 'package:flutter_application_1/bloc/US_model.dart';
import "UserModel.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'UserRepo.dart';
import 'UserEvents.dart';
import 'UserStates.dart';

class UserBloc extends Bloc<user_Event, StateBlock> {
  final UserRepo _userRepo;

  UserBloc(this._userRepo) : super(BlocInitial()) {
    on<user_Event>((event, emit) async {
      emit(BlocInitial());
      try {
        if (event is userAdd_Event) {
          await _userRepo.AddUser(event.Email, event.Password, event.UserName,
              event.BirthDate, event.uid.toString());
          List<UserModel> data = [];

          emit(BlocSuccess(data));
        }

        if (event is userDelete_Event) {
          emit(BlocLoad());
          await _userRepo.Delete_User(event.uid);
          List<UserModel> data = [];
          emit(BlocSuccess(data));
        }

        if (event is readUser_Event) {
          emit(BlocLoad());
          final UserModel data = await _userRepo.Read_User(event.uid);
          List<UserModel> data2 = [data];
          emit(BlocSuccess(data2));
        }

        if (event is readAllUser_Event) {
          emit(BlocLoad());
          final List<UserModel> data = await _userRepo.ReadAllUser();
          emit(BlocSuccess(data));
        }

        if (event is userUpdate_Event) {
          emit(BlocLoad());
          await _userRepo.UpdateUser(event.Email, event.Password,
              event.UserName, event.BirthDate, event.id);
          // UserModel data = UserModel();
          emit(BlocLoad());
        }
      } catch (e) {
        print(e);
        emit(BlocError(e.toString()));
      }
    });
  }
}
