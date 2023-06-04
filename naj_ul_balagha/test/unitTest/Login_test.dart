import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naj_ul_balagha/OnBoarding/Login.dart';

// Mock FirebaseAuth class
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock UserCredential class
class MockUserCredential extends Mock implements UserCredential {}

// Mock User class
class MockUser extends Mock implements User {}

// Mock GoogleSignIn class
class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late Login login;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockGoogleSignIn mockGoogleSignIn;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockGoogleSignIn = MockGoogleSignIn();
    login = Login(changeLocale: (locale) {});
  });

  testWidgets('Login page UI elements test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: login));

    // Check if email and password text fields are displayed
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Check if the login button is displayed
    expect(find.text('Login'), findsOneWidget);

    // Check if the Google sign-in button is displayed
    expect(find.byKey(const ValueKey("SignUp")), findsOneWidget);
  });

  testWidgets('Email and password validation test',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: login));

    // Empty email and password
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Please Enter Email'), findsOneWidget);
    expect(find.text('Please Enter Password'), findsOneWidget);

    // Invalid email format
    await tester.enterText(find.byType(TextFormField).first, 'invalidemail');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Please Enter Valid Email'), findsOneWidget);

    // Valid email format and empty password
    await tester.enterText(
        find.byType(TextFormField).first, 'test@example.com');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Please Enter Password'), findsOneWidget);

    // Valid email and invalid password format
    await tester.enterText(find.byType(TextFormField).last, 'password');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(
        find.text(
            'Password must contain at least 8 characters, including uppercase,\nlowercase letters and numbers'),
        findsOneWidget);

    // Valid email and password format
    await tester.enterText(find.byType(TextFormField).last, 'Password1');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Validated'), findsOneWidget);
  });

  testWidgets('Sign in using email and password test',
      (WidgetTester tester) async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(
      email: "Ali",
      password: "Pass",
    )).thenAnswer((_) async => mockUserCredential);

    when(mockUserCredential.user).thenReturn(mockUser);

    await tester.pumpWidget(MaterialApp(home: login));

    await tester.enterText(
        find.byType(TextFormField).first, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'Password1');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    verify(mockFirebaseAuth.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: 'Password1',
    )).called(1);

    verify(mockUserCredential.user).called(1);
    expect(find.text('Login Successful'), findsOneWidget);
  });

  testWidgets('Sign in with Google test', (WidgetTester tester) async {
    when(mockGoogleSignIn.signIn())
        .thenAnswer((_) async => MockGoogleSignInAccount());

    when(mockGoogleSignIn.signInSilently())
        .thenAnswer((_) async => MockGoogleSignInAccount());

    when(mockGoogleSignIn.currentUser).thenReturn(MockGoogleSignInAccount());

    when(mockGoogleSignInAccount.authentication)
        .thenAnswer((_) async => MockGoogleSignInAuthentication());

    when(mockFirebaseAuth.signInWithCredential(any))
        .thenAnswer((_) async => mockUserCredential);

    when(mockUserCredential.user).thenReturn(mockUser);

    await tester.pumpWidget(MaterialApp(home: login));

    await tester.tap(find.byKey(const ValueKey("SignUp")));
    await tester.pumpAndSettle();

    verify(mockGoogleSignIn.signIn()).called(1);

    verify(mockGoogleSignIn.signInSilently()).called(1);

    verify(mockGoogleSignIn.currentUser).called(1);

    verify(mockGoogleSignInAccount.authentication).called(1);

    verify(mockFirebaseAuth.signInWithCredential(any)).called(1);

    verify(mockUserCredential.user).called(1);
    expect(find.text('Login Successful'), findsOneWidget);
  });
}
