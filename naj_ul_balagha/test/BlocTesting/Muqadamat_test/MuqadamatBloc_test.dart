import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:naj_ul_balagha/InApplication/Muqadmat/MuqadamatBloc.dart';
import 'package:naj_ul_balagha/InApplication/Muqadmat/MuqadamatEvents.dart';
import 'package:naj_ul_balagha/InApplication/Muqadmat/MuqadamatStates.dart';

import 'MockMuqadamatRepo.dart';

void main() {
  group("Muqadamat Test", (() {
    late MuqadamatBloc muqadamatBloc;
    late MockMuqadamatRepo mockMuqadamatRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockMuqadamatRepo = MockMuqadamatRepo();
      muqadamatBloc = MuqadamatBloc(repository: mockMuqadamatRepo);
    });

    blocTest<MuqadamatBloc, MuqadamatStates>(
      "test for Read success",
      build: () => muqadamatBloc,
      act: (bloc) => bloc.add(MuqadamatReadEvent(Type: 1)),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocLoad>(), isA<BlocSuccess>()],
    );

    // error state
    blocTest<MuqadamatBloc, MuqadamatStates>(
      "test for Read error",
      build: () => muqadamatBloc,
      act: (bloc) => bloc.add(MuqadamatReadEvent(Type: 1009)),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocLoad>(), isA<BlocError>()],
    );
  }));
}
