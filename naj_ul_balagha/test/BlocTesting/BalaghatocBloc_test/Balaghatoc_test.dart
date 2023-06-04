import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_toc/balaghatocEvents.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_toc/balaghatocStates.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_toc/balaghatocbloc.dart';

import 'MockBalaghatocRepo.dart';

void main() {
  group("Balagha Toc Test ", () {
    late balaghaBloc balaghaTocBloc;
    late MockBalaghatocRepo mockBalaghaTocRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockBalaghaTocRepo = MockBalaghatocRepo();
      balaghaTocBloc = balaghaBloc(repository: mockBalaghaTocRepo);
    });

    blocTest<balaghaBloc, tocStateBloc>(
      "test for Read success",
      build: () => balaghaTocBloc,
      act: (bloc) => bloc.add(tocReadEvent(TypeId: 1)),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocLoad>(), isA<BlocSuccess>()],
    );

    // error state
    blocTest<balaghaBloc, tocStateBloc>(
      "test for Read error",
      build: () => balaghaTocBloc,
      act: (bloc) => bloc.add(tocReadEvent(TypeId: 1009)),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocLoad>(), isA<BlocError>()],
    );

    tearDown(() async {
      await balaghaTocBloc.close();
    });
  });
}
