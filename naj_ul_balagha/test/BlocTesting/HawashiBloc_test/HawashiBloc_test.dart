import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:naj_ul_balagha/InApplication/Hawashi/HawashiBloc.dart';
import 'package:naj_ul_balagha/InApplication/Hawashi/HawashiEvent.dart';
import 'package:naj_ul_balagha/InApplication/Hawashi/HawashiState.dart';

import 'MockHawashiRep.dart';

void main() {
  group("Hawashi Bloc Test", () {
    late HawashiBloc hawashiBloc;
    late MockHawashiRepo mockHawashiRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockHawashiRepo = MockHawashiRepo();
      hawashiBloc = HawashiBloc(repository: mockHawashiRepo);
    });

    blocTest<HawashiBloc, HawashiState>(
      "test for Read success",
      build: () => hawashiBloc,
      act: (bloc) => bloc.add(HawashiReadAllEvent()),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocLoad>(), isA<BlocSuccess>()],
    );

    // blocTest<HawashiBloc, HawashiState>(
    //   "test for Read error",
    //   build: () => hawashiBloc,
    //   act: (bloc) => bloc.add(HawashiReadAllEvent()),
    //   wait: const Duration(seconds: 2),
    //   expect: () => [isA<BlocLoad>(), isA<BlocError>()],
    // );
  });
}
