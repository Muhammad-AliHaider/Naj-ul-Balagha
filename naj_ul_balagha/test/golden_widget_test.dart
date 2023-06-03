import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:glob/glob.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naj_ul_balagha/InApplication/HomePage.dart';
import 'package:naj_ul_balagha/OnBoarding/Login.dart';
import 'package:naj_ul_balagha/OnBoarding/Signup.dart';

import 'package:naj_ul_balagha/main.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

//  end

void main() {
  // testGoldens('Naj_ul_balagha LoginPage', (tester) async {
  //   // final builder = DeviceBuilder()
  //   //   ..overrideDevicesForAllScenarios(devices: [
  //   //     Device.phone,
  //   //     Device.iphone11,
  //   //     Device.tabletPortrait,
  //   //     Device.tabletLandscape,
  //   //   ]);
  //   await tester.pumpWidget(const MyApp());
  //   await tester.pumpAndSettle();
  //   // final button = find.byKey(const ValueKey("SignUp"));

  //   // expect(button, findsOneWidget);

  //   await expectLater(
  //       find.byType(MyApp), matchesGoldenFile('goldens/login.png'));
  // });
  // group("App Navigation", () {
  //   VerifyLogin(tester) async {
  //     await tester.pumpAndSettle();
  //     await expectLater(
  //         find.byType(MyApp), matchesGoldenFile('goldens/login.png'));
  //   }

  //   VerifySignUp(tester) async {
  //     // await tester.pumpWidget(const MyApp());
  //     await tester.pumpAndSettle();

  //     final button = find.byKey(const ValueKey("SignUp"));

  //     expect(button, findsOneWidget);

  //     await tester.tap(button);
  //     await tester.pumpAndSettle();

  //     await expectLater(
  //       find.byType(MyApp),
  //       matchesGoldenFile('goldens/signup.png'),
  //     );
  //   }

  //   testGoldens('Naj_ul_balagha LoginPage', (tester) async {
  //     await tester.pumpWidget(const MyApp());

  //     await VerifyLogin(tester);

  //     expectLater(find.byType(MyApp), matchesGoldenFile('goldens/login.png'));

  //     // await VerifySignUp(tester);

  //     // expectLater(find.byType(SignUp), matchesGoldenFile('goldens/signup.png'));
  //   });
  // });

  testGoldens('Naj_ul_balagha SignUpPage', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUp()));
    await tester.pumpAndSettle();

    // final button = find.byKey(const ValueKey("SignUp"));

    // expect(button, findsOneWidget);

    // await tester.tap(button);
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(SignUp),
      matchesGoldenFile('goldens/signup.png'),
    );
  });

  testGoldens('Naj_ul_balagha HomePage', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
          home: HomePage(
        changeLocale: (Locale) {},
      )),
    );

    await tester.pumpAndSettle();
    await expectLater(
      find.byType(HomePage),
      matchesGoldenFile('goldens/HomePage.png'),
      skip: false, // Set skip to false to generate the golden image
    );
  });
}
//   testGoldens('Naj_ul_balagha SignUpPage', (WidgetTester tester) async {
//     await tester.pumpWidget(const MyApp());
//     await tester.pumpAndSettle();

//     final button = find.byKey(const ValueKey("SignUp"));

//     expect(button, findsOneWidget);

//     await tester.tap(button);
//     await tester.pumpAndSettle();

//     await expectLater(
//       find.byType(MyApp),
//       matchesGoldenFile('goldens/signup.png'),
//     );
//   });

//   // testGoldens('Naj_ul_balagha HomePage', (WidgetTester tester) async {
//   //   await loadAppFonts();
//   //   await tester.pumpWidgetBuilder(
//   //     MaterialApp(
//   //         home: HomePage(
//   //       changeLocale: (Locale) {},
//   //     )),
//   //   );

//   //   await tester.pumpAndSettle();
//   //   await expectLater(
//   //     find.byType(HomePage),
//   //     matchesGoldenFile('goldens/HomePage.png'),
//   //     skip: false, // Set skip to false to generate the golden image
//   //   );
//   // });

//   // testGoldens('Naj_ul_balagha SignUpPage', (tester) async {
//   //   final builder = DeviceBuilder()
//   //     ..overrideDevicesForAllScenarios(devices: [
//   //       Device.phone,
//   //       Device.iphone11,
//   //       Device.tabletPortrait,
//   //       Device.tabletLandscape,
//   //     ]);

//   //   await tester.pumpWidget(const MyApp());
//   //   await tester.pumpAndSettle();

//   //   // debugDumpRenderTree();
//   //   // final SFarea = find.byType(SafeArea);
//   //   // final ltView = find.descendant(of: SFarea, matching: find.byType(ListView));
//   //   // final SCSview = find.descendant(
//   //   //     of: ltView, matching: find.byType(SingleChildScrollView));
//   //   // final Frm = find.descendant(of: SCSview, matching: find.byType(Form));
//   //   // final col = find.descendant(of: Frm, matching: find.byType(Column));
//   //   // final row = find.descendant(of: col, matching: find.byType(Row));
//   //   // final button = find.descendant(of: row, matching: find.byType(TextButton));

//   //   // final rowWidget = find.byType(Row);
//   //   // final textButton = find.descendant(
//   //   //   of: rowWidget,
//   //   //   matching: find.byType(Semantics),
//   //   // );

//   //   final textButton = find.byWidgetPredicate((widget) {
//   //     if (widget is Text && widget.data == "Don't have an account?") {
//   //       return true;
//   //     }
//   //     return false;
//   //   });
//   //   await tester.pumpAndSettle();
//   //   expect(textButton, findsOneWidget);

//   //   // await tester.tap(button);
//   //   // await tester.tap(button);
//   //   await tester.pumpAndSettle();

//   //   await expectLater(
//   //       find.byType(MyApp), matchesGoldenFile('goldens/signup.png'));
//   // });
// }

// void main() {
//   testGoldens('Find Sign Up TextButton', (WidgetTester tester) async {
//     await tester.pumpWidgetBuilder(
//       MaterialApp(home: const SignUp()),
//     );

//     await tester.pumpAndSettle();
//     await expectLater(
//       find.byType(SignUp),
//       matchesGoldenFile('goldens/signup.png'),
//       skip: false, // Set skip to false to generate the golden image
//     );
//   });
// }
