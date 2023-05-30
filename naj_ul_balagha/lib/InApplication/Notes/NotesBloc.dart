import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/SignUp/UserModel.dart';
// import 'package:flutter_application_1/bloc/US_model.dart';
import "NotesModel.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import './Repo/NotesRepo.dart';
import 'NotesEvents.dart';
import 'NotesStates.dart';

class NotesBloc extends Bloc<NotesEvent, NotesStates> {
  final NotesRepo repository;

  NotesBloc({required this.repository}) : super(BlocInitial()) {
    on<NotesEvent>((event, emit) async {
      emit(BlocInitial());
      try {
        if (event is NotesAddEvent) {
          await repository.AddNote(
              event.uid.toString(), event.title, event.content);
          // List<NotesModel> data = [];

          emit(BlocMove());
        }

        if (event is NotesDeleteEvent) {
          emit(BlocLoad());
          await repository.DeleteNote(event.id);
          List<NotesModel> data = [];
          emit(BlocMove());
        }

        if (event is readNotesEvent) {
          emit(BlocLoad());
          final NotesModel data = await repository.ReadNote(event.id);
          List<NotesModel> data2 = [data];
          emit(BlocSuccess(data2));
        }

        if (event is readAllNotesEvent) {
          emit(BlocLoad());
          final List<NotesModel> data =
              await repository.ReadAllNotes(event.uid);
          emit(BlocSuccess(data));
        }

        if (event is NotesUpdateEvent) {
          emit(BlocLoad());
          // String uid, String title, String content, String id
          await repository.UpdateNote(
              event.uid, event.title, event.content, event.id);
          // List<UserModel> data = [];
          emit(BlocMove());
        }
      } catch (e) {
        print(e);
        emit(BlocError(e.toString()));
      }
    });
  }
}
