import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_text/BalaghatextRepo/BalaghatextRepo.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_text/BalaghatextEvents.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_text/BalaghatextModel.dart';
import './MockBalaghaTextRepo.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_text/BalaghatextStates.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_text/Balaghatextbloc.dart';

void main() {
  group("BalaghaTextBloc Test", () {
    late BalaghaTextBloc balaghaTextBloc;
    late MockBalaghaTextRepo mockBalaghaTextRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockBalaghaTextRepo = MockBalaghaTextRepo();
      balaghaTextBloc = BalaghaTextBloc(mockBalaghaTextRepo);
    });

    blocTest<BalaghaTextBloc, textStateBloc>(
      "test for Read success",
      build: () => balaghaTextBloc,
      act: (bloc) => bloc.add(textReadEvent(Type: 1, TypeNo: 1)),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocLoad>(), isA<BlocSuccess>()],
    );

    // error state
    blocTest<BalaghaTextBloc, textStateBloc>(
      "test for Read error",
      build: () => balaghaTextBloc,
      act: (bloc) => bloc.add(textReadEvent(Type: 1009, TypeNo: 2)),
      wait: const Duration(seconds: 2),
      expect: () => [isA<BlocLoad>(), isA<BlocError>()],
    );

    tearDown(() async {
      await balaghaTextBloc.close();
    });
  });
}
