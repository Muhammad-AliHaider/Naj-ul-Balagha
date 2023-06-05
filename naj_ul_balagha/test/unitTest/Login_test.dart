import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:naj_ul_balagha/InApplication/HomePage.dart';
import 'package:naj_ul_balagha/OnBoarding/Login.dart';
// import 'package:mockito/mockito.dart';

// class MockNavigatorObserver extends Mock implements NavigatorObserver {}
// // class MockNavigatorObserver extends Mock implements NavigatorObserver {}

// // Mock FirebaseAuth class
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// // Mock UserCredential class
// class MockUserCredential extends Mock implements UserCredential {}

// // Mock User class
// class MockUser extends Mock implements User {}

// // Mock GoogleSignIn class
// class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockChangeLocale extends Mock {
  void call(Locale locale);
}

void main() {
  group("Login Page Test", () {
    late MockChangeLocale mockChangeLocale;
    // late Login login;
    // late MockFirebaseAuth mockFirebaseAuth;
    // late MockUserCredential mockUserCredential;
    // late MockUser mockUser;
    // late MockGoogleSignIn mockGoogleSignIn;
    // late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      mockChangeLocale = MockChangeLocale();
      // mockFirebaseAuth = MockFirebaseAuth();
      // mockUserCredential = MockUserCredential();
      // mockUser = MockUser();
      // mockGoogleSignIn = MockGoogleSignIn();
      // login = Login(changeLocale: (locale) {});
      // mockNavigatorObserver = MockNavigatorObserver();
    });

    testWidgets('Login page UI elements test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Login(changeLocale: mockChangeLocale),
        // navigatorObservers: [MockNavigatorObserver()],
      ));

      await tester.pumpAndSettle();

      // Check if email and password text fields are displayed
      expect(find.byType(TextFormField), findsNWidgets(2));

      // Check if the login button is displayed
      expect(find.text('Login'), findsOneWidget);

      // Check if the Google sign-in button is displayed
      expect(find.byKey(const ValueKey("SignUp")), findsOneWidget);

      verify(mockChangeLocale.call(const Locale('en', 'US')));

      // Empty email and password
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      expect(find.text('Please Enter Email'), findsOneWidget);
      expect(find.text('Please Enter Password'), findsOneWidget);

      // // Invalid email format
      await tester.enterText(find.byType(TextFormField).first, 'invalidemail');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      expect(find.text('Please Enter Valid Email'), findsOneWidget);

      // // Valid email format and empty password
      await tester.enterText(
          find.byType(TextFormField).first, 'test@example.com');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      expect(find.text('Please Enter Password'), findsOneWidget);

      // // Valid email and invalid password format
      await tester.enterText(find.byType(TextFormField).last, 'password');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      expect(
          find.text(
              'Password must contain at least 8 characters, including uppercase,\nlowercase letters and numbers'),
          findsOneWidget);
    });

    // testWidgets('Email and password validation test',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     home: Login(changeLocale: mockChangeLocale),
    //     // navigatorObservers: [MockNavigatorObserver()],
    //   ));

    //   await tester.pumpAndSettle();

    //   // Future.delayed(const Duration(seconds: 5));

    //   // await tester.pumpAndSettle();

    //   // expect(find.byKey(ValueKey('Login')), findsOneWidget);

    //   verify(mockChangeLocale.call(const Locale('en', 'US')));

    //   // Empty email and password
    //   await tester.tap(find.text('Login'));
    //   await tester.pumpAndSettle();
    //   expect(find.text('Please Enter Email'), findsOneWidget);
    //   expect(find.text('Please Enter Password'), findsOneWidget);

    //   // // Invalid email format
    //   await tester.enterText(find.byType(TextFormField).first, 'invalidemail');
    //   await tester.tap(find.text('Login'));
    //   await tester.pumpAndSettle();
    //   expect(find.text('Please Enter Valid Email'), findsOneWidget);

    //   // // Valid email format and empty password
    //   await tester.enterText(
    //       find.byType(TextFormField).first, 'test@example.com');
    //   await tester.tap(find.text('Login'));
    //   await tester.pumpAndSettle();
    //   expect(find.text('Please Enter Password'), findsOneWidget);

    //   // // Valid email and invalid password format
    //   await tester.enterText(find.byType(TextFormField).last, 'password');
    //   await tester.tap(find.text('Login'));
    //   await tester.pumpAndSettle();
    //   expect(
    //       find.text(
    //           'Password must contain at least 8 characters, including uppercase,\nlowercase letters and numbers'),
    //       findsOneWidget);

    //   // // Valid email and password format
    //   // await tester.enterText(find.byType(TextFormField).first, 'test@gmail.com');
    //   // await tester.enterText(find.byType(TextFormField).last, '123qweA!');
    //   // await tester.tap(find.text('Login'));
    //   // await tester.pumpAndSettle();
    //   // verify(mockNavigatorObserver.didPush());
    //   // verify(mockNavigatorObserver.didPop());
    //   // await Future.delayed(const Duration(seconds: 10));
    //   // expect(find.byType(HomePage), findsOneWidget);
    // });

    // testWidgets("Error", (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     home: Login(changeLocale: mockChangeLocale),
    //     // navigatorObservers: [MockNavigatorObserver()],
    //   ));

    //   await tester.pumpAndSettle();

    //   // Empty email and password
    //   await tester.tap(find.text('Login'));
    //   await tester.pumpAndSettle();
    //   expect(find.text('Please Enter Email'), findsOneWidget);
    //   expect(find.text('Please Enter Password'), findsOneWidget);
    // });

    // testWidgets('Sign in using email and password test',
    //     (WidgetTester tester) async {
    //   when(mockFirebaseAuth.signInWithEmailAndPassword(
    //     email: "Ali",
    //     password: "Pass",
    //   )).thenAnswer((_) async => mockUserCredential);

    //   when(mockUserCredential.user).thenReturn(mockUser);

    //   await tester.pumpWidget(MaterialApp(home: login));

    //   await tester.enterText(
    //       find.byType(TextFormField).first, 'test@example.com');
    //   await tester.enterText(find.byType(TextFormField).last, 'Password1');
    //   await tester.tap(find.text('Login'));
    //   await tester.pumpAndSettle();

    //   verify(mockFirebaseAuth.signInWithEmailAndPassword(
    //     email: 'test@example.com',
    //     password: 'Password1',
    //   )).called(1);

    //   // verify(mockUserCredential.user).called(1);
    //   // expect(find.text('Login Successful'), findsOneWidget);
    // });
  });
}
