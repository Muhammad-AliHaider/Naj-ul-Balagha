import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:naj_ul_balagha/OnBoarding/Signup.dart';
import 'package:naj_ul_balagha/OnBoarding/bloc/UserBloc.dart';
import 'package:naj_ul_balagha/OnBoarding/bloc/UserEvents.dart';

import '../BlocTesting/UserBlocTest/MockUserRepo.dart';

void main() {
  late UserBloc userBloc;
  late SignUp signUp;
  late MockUserRepository mockUserRepo;

  setUp(() {
    mockUserRepo = MockUserRepository();
    userBloc = UserBloc(mockUserRepo);
    signUp = SignUp();
  });

  testWidgets('SignUp form validation', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: signUp,
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey('sign_up_button')));

    await tester.pumpAndSettle();

    expect(find.text('Please Enter Email'), findsOneWidget);
    expect(find.text('Please Enter Password'), findsOneWidget);
    expect(find.text('Please Enter UserName'), findsOneWidget);
    expect(find.text('Please Enter BirthDate'), findsOneWidget);
    expect(find.text('Please Enter Confirm Password'), findsOneWidget);

    // // Fill in the email field
    await tester.enterText(find.byKey(ValueKey('email_field')), 'test.com');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('sign_up_button')));

    await tester.pumpAndSettle();

    expect(find.text('Please Enter Valid Email'), findsOneWidget);

    await tester.enterText(find.byKey(ValueKey('password_field')), 'qweas');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('sign_up_button')));

    await tester.pumpAndSettle();

    expect(
        find.text(
            'Password must contain at least 8 characters, including uppercase,\nlowercase letters and numbers'),
        findsOneWidget);

    await tester.enterText(find.byKey(ValueKey('password_field')), '123qweA!');
    await tester.enterText(
        find.byKey(ValueKey('confirm_password_field')), '789456123');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('sign_up_button')));

    await tester.pumpAndSettle();

    expect(find.text('Password Not Match'), findsOneWidget);

    await tester.enterText(
        find.byKey(ValueKey('email_field')), "test@gmail.com");

    // Fill in the password field
    await tester.enterText(find.byKey(ValueKey('password_field')), '123qweA!');
    await tester.pump();

    // Fill in the confirm password field
    await tester.enterText(
        find.byKey(ValueKey('confirm_password_field')), '123qweA!');
    await tester.pump();

    // Fill in the username field
    await tester.enterText(find.byKey(ValueKey('username_field')), 'testuser');
    await tester.pump();

    await tester.tap(find.byKey(ValueKey('birthdate_field')));
    expect(
        find.byKey(
          ValueKey('birthdate_field'),
        ),
        findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(find.text('15'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // // Tap on the Sign Up button
    await tester.tap(find.byKey(ValueKey('sign_up_button')));
    await tester.pumpAndSettle();

    // expect(find.byType(SnackBar), findsOneWidget);

    // Verify that the userBloc receives the userAdd_Event
    // verify(userBloc.add(userAdd_Event(
    //   Email: 'test@example.com',
    //   Password: 'test1234',
    //   UserName: 'testuser',
    //   BirthDate: '2021-06-01',
    //   uid: '5',
    // ))).called(1);
  });
}
