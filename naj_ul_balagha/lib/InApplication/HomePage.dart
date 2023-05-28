import 'package:flutter/material.dart';
import 'package:google_language_fonts/google_language_fonts.dart';
import 'package:persian_fonts/persian_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // SizedBox(
          //     child: Container(
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           Color.fromARGB(255, 2, 117, 0),
          //           Color.fromARGB(252, 3, 248, 138)
          //         ]),
          //   ),
          // )),
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Center(
              child: Text(
                'نهج البلاغة',
                style: ArabicFonts.amiri(
                  textStyle: TextStyle(fontSize: 50),
                  color: Color.fromARGB(255, 65, 205, 149),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                child: Image.asset(
                  'assets/images/My project.png',
                ),
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/test');
                },
                child: Text(
                  'حرف آغاز',
                  style: ArabicFonts.amiri(fontSize: 30),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 65, 205, 149),
                  minimumSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/test');
                },
                child: Text('خطبات', style: ArabicFonts.amiri(fontSize: 30)),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 65, 205, 149),
                  minimumSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/test');
                },
                child: Text(
                  'مکتوبات',
                  style: ArabicFonts.amiri(fontSize: 30),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 65, 205, 149),
                  minimumSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/test');
                },
                child: Text(
                  'حکم و مواعظ',
                  style: ArabicFonts.amiri(fontSize: 30),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 65, 205, 149),
                  minimumSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/test');
                },
                child: Text(
                  'تشریح طلب کلام',
                  style: ArabicFonts.amiri(fontSize: 30),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 65, 205, 149),
                  minimumSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 65, 205, 149),
                Color.fromARGB(84, 73, 236, 201)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notes),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
