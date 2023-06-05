import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:naj_ul_balagha/InApplication/Notes/NotesBloc.dart';
import 'package:naj_ul_balagha/InApplication/Notes/NotesEvents.dart';
import 'package:naj_ul_balagha/InApplication/Notes/NotesStates.dart';

import 'MockNoteRepo.dart';

void main() {
  group("Notes Bloc Test", () {
    late NotesBloc notesBloc;
    late MockNoteRepo mockNotesRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockNotesRepo = MockNoteRepo();
      notesBloc = NotesBloc(repository: mockNotesRepo);
    });

    blocTest<NotesBloc, NotesStates>(
      "test for Read success",
      build: () => notesBloc,
      act: (bloc) {
        bloc.add(readAllNotesEvent(uid: '3'));
      },
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocInitial>(), isA<BlocLoad>(), isA<BlocSuccess>()],
    );

    blocTest<NotesBloc, NotesStates>(
      "test for Read success",
      build: () => notesBloc,
      act: (bloc) {
        bloc.add(readAllNotesEvent(uid: '3'));
        Future.delayed(const Duration(seconds: 8));
        bloc.add(readNotesEvent(id: "0"));
      },
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<BlocInitial>(),
        isA<BlocLoad>(),
        isA<BlocInitial>(),
        isA<BlocLoad>(),
        isA<BlocSuccess>(),
      ],
    );

    blocTest<NotesBloc, NotesStates>(
      "test for Add success",
      build: () => notesBloc,
      act: (bloc) {
        bloc.add(NotesAddEvent(
            uid: "3", title: "Test Title 4", content: "Test Content 4"));
      },
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<BlocInitial>(),
        isA<BlocMove>(),
      ],
    );

    blocTest<NotesBloc, NotesStates>(
      "test for Delete success",
      build: () => notesBloc,
      act: (bloc) {
        bloc.add(readAllNotesEvent(uid: '3'));
        Future.delayed(const Duration(seconds: 10));
        bloc.add(NotesDeleteEvent(id: "0"));
      },
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<BlocInitial>(),
        isA<BlocLoad>(),
        isA<BlocInitial>(),
        isA<BlocLoad>(),
        isA<BlocMove>(),
        isA<BlocSuccess>(),
      ],
    );

    blocTest<NotesBloc, NotesStates>(
      "test for Update success",
      build: () => notesBloc,
      act: (bloc) {
        bloc.add(readAllNotesEvent(uid: '3'));
        Future.delayed(const Duration(seconds: 10));
        bloc.add(NotesUpdateEvent(
            content: "Test Content 4",
            title: "Test Title 4",
            uid: '3',
            id: '0'));
      },
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<BlocInitial>(),
        isA<BlocLoad>(),
        isA<BlocInitial>(),
        isA<BlocLoad>(),
        isA<BlocMove>(),
        isA<BlocSuccess>(),
      ],
    );

    // error State
    blocTest<NotesBloc, NotesStates>(
      "test for Read Error",
      build: () => notesBloc,
      act: (bloc) {
        bloc.add(readAllNotesEvent(uid: '3'));
        bloc.add(readNotesEvent(id: "100000"));
      },
      wait: const Duration(seconds: 4),
      expect: () => [
        isA<BlocInitial>(),
        isA<BlocLoad>(),
        isA<BlocInitial>(),
        isA<BlocLoad>(),
        isA<BlocSuccess>(),
        isA<BlocError>()
      ],
    );
    tearDown(() async {
      await notesBloc.close();
    });
  });
}
