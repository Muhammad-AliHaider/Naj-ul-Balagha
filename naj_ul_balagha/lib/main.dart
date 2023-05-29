import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:naj_ul_balagha/InApplication/HomePage.dart';
import 'package:naj_ul_balagha/InApplication/IndexedPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:naj_ul_balagha/OnBoarding/Login.dart';

import 'InApplication/ProfileOptions.dart';
import 'InApplication/UpdateUser.dart';
import 'OnBoarding/Signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return APP();
  }
}

class APP extends StatefulWidget {
  @override
  State<APP> createState() => _APPState();
}

class _APPState extends State<APP> {
  Locale _currentLocale = const Locale('en', 'US');

  changeLocale(Locale newLocale) {
    setState(() {
      _currentLocale = newLocale;
      print(_currentLocale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Login(
              changeLocale: changeLocale,
            ),
        '/SignUp': (context) => SignUp(),
        '/HomePage': (context) => HomePage(
              changeLocale: changeLocale,
            ),

        '/Profile': (context) => Profile(changeLocale: changeLocale),
        '/UpdateUser': (context) => UpdateUser(),
        '/test': (context) => const MyHomePage(title: "avc"),
        // '/IndexPage': (context) => BalaghaToc()
      },
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en", "US"),
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: _currentLocale, // OR Locale('ar', 'AE') OR Other RTL locales,

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
        IconButton(
          onPressed: () {
            // Navigator.popUntil(context, (route) => route.isFirst);
            FirebaseAuth.instance.signOut();
            Navigator.popAndPushNamed(context, '/');
          },
          icon: const Icon(Icons.logout),
        )
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
