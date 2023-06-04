import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:naj_ul_balagha/InApplication/HomePage.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:glob/glob.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:naj_ul_balagha/OnBoarding/Login.dart';
import 'package:naj_ul_balagha/OnBoarding/Signup.dart';
import 'package:naj_ul_balagha/InApplication/Notes/pages/NoteAdd.dart';
import 'package:naj_ul_balagha/OnBoarding/bloc/UserBloc.dart';
import 'package:naj_ul_balagha/OnBoarding/bloc/UserStates.dart';
import 'package:naj_ul_balagha/OnBoarding/bloc/UserRepo.dart';
import 'package:naj_ul_balagha/main.dart';

void main() {
  setUpAll(() async {
    await GoldenToolkit.runWithConfiguration(
      () async {
        // Execute your tests
      },
      config: GoldenToolkitConfiguration(
        enableRealShadows: true,
        skipGoldenAssertion: () => false,
      ),
    );
  });

  testGoldens('HomePage renders correctly', (tester) async {
    final widget = MaterialApp(
      home: HomePage(
        changeLocale: (Locale locale) {},
      ),
    );

    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(
          500, 1000), // The size can be adjusted as per the requirements
    );

    await screenMatchesGolden(tester, 'home_page');
  });

  testGoldens('Golden test for SignUp page', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: SignUp(),
      ),
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'sign_up_page');
  });

  testGoldens('Login Page Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(home: Login(changeLocale: (_) {})),
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'slogin_page');
  });

  testGoldens('NoteAdd Widget Golden Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(home: NoteAdd()),
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'note_add_page');
  });
}
