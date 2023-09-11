import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_text/Pages/ReadingPage.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_toc/Pages/IndexedPage.dart';
import 'package:naj_ul_balagha/InApplication/Bookmarks/Pages/BookmarksView.dart';
import 'package:naj_ul_balagha/InApplication/Hawashi/Pages/HawashiView.dart';
import 'package:naj_ul_balagha/InApplication/HomePage.dart';

import 'package:mockito/mockito.dart';
import 'package:naj_ul_balagha/InApplication/Muqadmat/Pages/PaishGhuftar.dart';
import 'package:naj_ul_balagha/InApplication/Muqadmat/Pages/RPHurf-e-Agas.dart';
import 'package:naj_ul_balagha/InApplication/Notes/pages/NotesUpdate.dart';
import 'package:naj_ul_balagha/InApplication/Notes/pages/NotesView.dart';
import 'package:naj_ul_balagha/InApplication/ProfileOptions.dart';
import 'package:naj_ul_balagha/InApplication/UpdateUser.dart';
import 'package:naj_ul_balagha/OnBoarding/Login.dart';
import 'package:naj_ul_balagha/OnBoarding/Signup.dart';
import 'package:naj_ul_balagha/InApplication/Notes/pages/NoteAdd.dart';
import 'BlocTesting/BalaghatextBloc_test/MockBalaghaTextRepo.dart';
import 'BlocTesting/BookmarkBloc_test/MockBookmarkRepo.dart';
import 'BlocTesting/HawashiBloc_test/MockHawashiRep.dart';
import 'BlocTesting/Muqadamat_test/MockMuqadamatRepo.dart';
import 'BlocTesting/Notes_test/MockNoteRepo.dart';
import 'BlocTesting/UserBlocTest/MockUserRepo.dart';
import 'MockFireBaseAuth.dart';

import 'BlocTesting/BalaghatocBloc_test/MockBalaghatocRepo.dart';

class MockChangeLocale extends Mock {
  void call(Locale locale);
}

void main() {
  late MockChangeLocale mockChangeLocale;
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

    mockChangeLocale = MockChangeLocale();
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

  testGoldens('Indexed Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
          home: BalaghaToc(
              changeLocale: mockChangeLocale,
              title: "Test",
              TypeId: 1,
              repo: MockBalaghatocRepo(),
              auth: MockFirebaseAuth())),
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'indexed_page');
  });

  testGoldens('NoteAdd Widget Golden Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
          home: NoteAdd(
        repo: MockNoteRepo(),
        auth: MockFirebaseAuth(),
      )),
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'note_add_page');
  });

  testGoldens("Profile Options", (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: Profile(
            changeLocale: mockChangeLocale,
            repo: MockUserRepository(),
            auth: MockFirebaseAuth()),
      ),
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'profile_page');
  });

  testGoldens("Update User", (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: UpdateUser(repo: MockUserRepository(), auth: MockFirebaseAuth()),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'update_user_page');
  });

  testGoldens("Bookmarks View", (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: BookmarksView(
            changeLocale: mockChangeLocale,
            repo: MockBookmarkRepo(),
            auth: MockFirebaseAuth()),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'bookmarks_view_page');
  });

  testGoldens("Reading Page_error", (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: ReadingPage(
          repo: MockBalaghaTextRepo(),
          auth: MockFirebaseAuth(),
          title: "Test",
          Type: 1,
          TypeNo: 1,
          totalTypeNo: 2,
        ),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'reading_page_error');
  });

  testGoldens("Reading Page ", (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: ReadingPage(
          repo: MockBalaghaTextRepo(),
          auth: MockFirebaseAuth(),
          title: "Test",
          Type: 1,
          TypeNo: 1,
          totalTypeNo: 1,
        ),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'reading_page');
  });

  testGoldens("Notes View", (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: NotesView(
            changeLocale: mockChangeLocale,
            repo: MockNoteRepo(),
            auth: MockFirebaseAuth()),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'notes_view_page');
  });

  testGoldens("Notes update", (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home:
            NoteUpdate(id: "1", repo: MockNoteRepo(), auth: MockFirebaseAuth()),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'notes_update_page');
  });

  testGoldens("Hawashi Test", (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: HawashiView(
          repo: MockHawashiRepo(),
        ),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'hawashi_page');
  });

  testGoldens("PaishGhuftar Test", (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: PaishGhuftar(
          repo: MockMuqadamatRepo(),
        ),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'PaishGhuftar_page');
  });

  testGoldens("RPHurf_e_agaz Test", (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: RPHurf(
          repo: MockMuqadamatRepo(),
          auth: MockFirebaseAuth(),
          Type: 1,
          totalTypeNo: 2,
        ),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'RP_Hurf_e_agaz_page');
  });
}
