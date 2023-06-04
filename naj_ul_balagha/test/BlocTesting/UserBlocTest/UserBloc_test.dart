import 'package:naj_ul_balagha/OnBoarding/bloc/UserBloc.dart';
import "./MockUserRepo.dart";
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:naj_ul_balagha/OnBoarding/bloc/UserStates.dart';
import 'package:naj_ul_balagha/OnBoarding/bloc/UserEvents.dart';

void main() {
  group("UserBloc Test", () {
    late UserBloc userBloc;
    late MockUserRepository mockUserRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockUserRepo = MockUserRepository();
      userBloc = UserBloc(mockUserRepo);
    });

    // All Success
    blocTest<UserBloc, StateBlock>(
      "test for Read success",
      build: () => userBloc,
      act: (bloc) => bloc.add(const readUser_Event(uid: "1")),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocInitial>(), isA<BlocLoad>(), isA<BlocSuccess>()],
    );

    blocTest<UserBloc, StateBlock>(
      "test for ReadAll success",
      build: () => userBloc,
      act: (bloc) => bloc.add(const readAllUser_Event()),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocInitial>(), isA<BlocLoad>(), isA<BlocSuccess>()],
    );

    blocTest<UserBloc, StateBlock>(
      "test for Add success",
      build: () => userBloc,
      act: (bloc) => bloc.add(userAdd_Event(
          Email: "Ali@gmail.com",
          Password: "123456",
          UserName: "Ali",
          BirthDate: "2023-05-24",
          uid: "4")),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocInitial>(), isA<BlocSuccess>()],
    );

    blocTest<UserBloc, StateBlock>(
      "test for Delete success",
      build: () => userBloc,
      act: (bloc) => bloc.add(userDelete_Event(uid: "10")),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocInitial>(), isA<BlocLoad>(), isA<BlocSuccess>()],
    );

    blocTest<UserBloc, StateBlock>(
      "test for Update success",
      build: () => userBloc,
      act: (bloc) => bloc.add(userUpdate_Event(
          Email: "ABC@gmail.com",
          Password: "123456",
          UserName: "ABC",
          BirthDate: "2023-05-24",
          id: "1")),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocInitial>(), isA<BlocLoad>(), isA<BlocMove>()],
    );

    // error States

    blocTest<UserBloc, StateBlock>(
      "test for Read error",
      build: () => userBloc,
      act: (bloc) => bloc.add(const readUser_Event(uid: "100")),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocInitial>(), isA<BlocLoad>(), isA<BlocError>()],
    );

    tearDown(() async {
      await userBloc.close();
    });
  });
}
