import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_toc/Pages/IndexedPage.dart';
import 'package:naj_ul_balagha/InApplication/HomePage.dart';
import 'package:naj_ul_balagha/InApplication/Notes/pages/NotesView.dart';
import 'package:naj_ul_balagha/main.dart';
import 'package:firebase_core/firebase_core.dart';

class MockChangeLocale extends Mock {
  void call(Locale locale);
}

void main() {
  group('HomePage', () {
    late MockChangeLocale mockChangeLocale;

    setUp(() {
      mockChangeLocale = MockChangeLocale();
      // await Firebase.initializeApp();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomePage(changeLocale: mockChangeLocale),
      ));

      await tester.pumpAndSettle();

      // Verify that the main title is rendered
      expect(find.text('نهج البلاغة'), findsOneWidget);

      // Verify that the buttons are rendered
      expect(find.text('حرف آغاز'), findsOneWidget);
      expect(find.text('خطبات'), findsOneWidget);
      expect(find.text('مکتوبات'), findsOneWidget);
      expect(find.text('حکم و مواعظ'), findsOneWidget);
      expect(find.text('تشریح طلب کلام'), findsOneWidget);
    });

    // testWidgets('navigate to BalaghaToc حرف آغاز on button press',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     initialRoute: '/',
    //     routes: {
    //       '/': (context) => HomePage(changeLocale: mockChangeLocale),
    //       // '/BalaghaToc': (context) => ,
    //     },
    //   ));

    //   await tester.pumpAndSettle();

    //   // Tap on the 'حرف آغاز' button
    //   final button = find.byKey(ValueKey('button1'));

    //   await tester.ensureVisible(button);

    //   print(button);

    //   expect(button, findsOneWidget);
    //   // verify(mockChangeLocale.call(const Locale('en', 'US')));
    //   // await tester.tap(button);

    //   await tester.pumpAndSettle();

    //   // // Verify that the navigation occurred

    //   await tester.pumpAndSettle();

    //   //expect(find.byType(BalaghaToc), findsOneWidget);
    //   // expect(find.text('حرف آغاز'), findsOneWidget);
    // });

    // testWidgets('navigate to BalaghaToc خطبات on button press',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     initialRoute: '/',
    //     routes: {
    //       '/': (context) => HomePage(changeLocale: mockChangeLocale),
    //       // '/BalaghaToc': (context) => ,
    //     },
    //   ));

    //   await tester.pumpAndSettle();

    //   // Tap on the 'حرف آغاز' button
    //   final button = find.byKey(ValueKey('button2'));

    //   await tester.ensureVisible(button);

    //   print(button);

    //   expect(button, findsOneWidget);
    //   await tester.tap(button);

    //   await tester.pumpAndSettle();

    //   // // Verify that the navigation occurred
    //   verify(mockChangeLocale.call(const Locale('fa', 'IR')));

    //   await tester.pumpAndSettle();

    //   expect(find.byType(BalaghaToc), findsOneWidget);
    //   // expect(find.text('حرف آغاز'), findsOneWidget);
    // });

    // testWidgets('navigate to BalaghaToc مکتوبات on button press',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     initialRoute: '/',
    //     routes: {
    //       '/': (context) => HomePage(changeLocale: mockChangeLocale),
    //       // '/BalaghaToc': (context) => ,
    //     },
    //   ));

    //   await tester.pumpAndSettle();

    //   // Tap on the 'حرف آغاز' button
    //   final button = find.byKey(ValueKey('button3'));

    //   await tester.ensureVisible(button);

    //   // print(button);

    //   expect(button, findsOneWidget);
    //   await tester.tap(button);

    //   await tester.pumpAndSettle();

    //   // // Verify that the navigation occurred
    //   verify(mockChangeLocale.call(const Locale('fa', 'IR')));

    //   await tester.pumpAndSettle();

    //   expect(find.byType(BalaghaToc), findsOneWidget);
    //   // expect(find.text('حرف آغاز'), findsOneWidget);
    // });

    // testWidgets('navigate to BalaghaToc حکم و مواعظ on button press',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     initialRoute: '/',
    //     routes: {
    //       '/': (context) => HomePage(changeLocale: mockChangeLocale),
    //       // '/BalaghaToc': (context) => ,
    //     },
    //   ));

    //   await tester.pumpAndSettle();

    //   // Tap on the 'حرف آغاز' button
    //   final button = find.byKey(ValueKey('button4'));

    //   await tester.ensureVisible(button);

    //   // print(button);

    //   expect(button, findsOneWidget);
    //   await tester.tap(button);

    //   await tester.pumpAndSettle();

    //   // // Verify that the navigation occurred
    //   verify(mockChangeLocale.call(const Locale('fa', 'IR')));

    //   await tester.pumpAndSettle();

    //   expect(find.byType(BalaghaToc), findsOneWidget);
    //   // expect(find.text('حرف آغاز'), findsOneWidget);
    // });

    // testWidgets('navigate to BalaghaToc تشریح طلب کلام on button press',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     initialRoute: '/',
    //     routes: {
    //       '/': (context) => HomePage(changeLocale: mockChangeLocale),
    //       // '/BalaghaToc': (context) => ,
    //     },
    //   ));

    //   await tester.pumpAndSettle();

    //   // Tap on the 'حرف آغاز' button
    //   final button = find.byKey(ValueKey('button5'));

    //   await tester.ensureVisible(button);

    //   // print(button);

    //   expect(button, findsOneWidget);
    //   await tester.tap(button);

    //   await tester.pumpAndSettle();

    //   // // Verify that the navigation occurred
    //   verify(mockChangeLocale.call(const Locale('fa', 'IR')));

    //   await tester.pumpAndSettle();

    //   expect(find.byType(BalaghaToc), findsOneWidget);
    //   // expect(find.text('حرف آغاز'), findsOneWidget);
    // });

    testWidgets('navigate to Notes on button press',
        (WidgetTester tester) async {
      // await Firebase.initializeApp();
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(changeLocale: mockChangeLocale),
          // '/BalaghaToc': (context) => ,
          '/NotesView': (context) => NotesView(changeLocale: mockChangeLocale),
        },
      ));

      await tester.pumpAndSettle();

      // Tap on the 'حرف آغاز' button
      final button = find.byKey(ValueKey('NotesButton'));

      await tester.ensureVisible(button);

      // print(button);

      expect(button, findsOneWidget);
      // await tester.tap(button);

      await tester.pumpAndSettle();

      // // Verify that the navigation occurred
      // verify(mockChangeLocale.call(const Locale('en', 'US')));

      // await tester.pumpAndSettle();

      // expect(find.byType(NotesView), findsOneWidget);
      // expect(find.text('حرف آغاز'), findsOneWidget);
    });
  });
}
