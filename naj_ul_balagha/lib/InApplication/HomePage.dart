import 'package:flutter/material.dart';
import 'package:google_language_fonts/google_language_fonts.dart';
import 'package:naj_ul_balagha/InApplication/IndexedPage.dart';
import 'package:persian_fonts/persian_fonts.dart';

class HomePage extends StatefulWidget {
  final Function(Locale) changeLocale;
  const HomePage({Key? key, required this.changeLocale}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initLocale();
    });
  }

  Future<void> _initLocale() async {
    await Future.delayed(Duration.zero); // Delay execution until after build
    widget.changeLocale(const Locale('en', 'US')); // Change to French locale
    setState(() {}); // Rebuild the widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              child: Image.asset(
            'assets/images/bg3.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          )),
          SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Text(
                  'نهج البلاغة',
                  // style: ArabicFonts.reemKufi(
                  //   textStyle: TextStyle(fontSize: 50),
                  //   color: Color.fromARGB(255, 65, 205, 149),
                  // ),
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

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalaghaToc(
                          TypeId: 5,
                          title: 'حرف آغاز',
                          changeLocale: widget.changeLocale,
                        ),
                      ),
                    );
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
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/test');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalaghaToc(
                          TypeId: 1,
                          title: 'خطبات',
                          changeLocale: widget.changeLocale,
                        ),
                      ),
                    );
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
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/test');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalaghaToc(
                          TypeId: 2,
                          title: 'مکتوبات',
                          changeLocale: widget.changeLocale,
                        ),
                      ),
                    );
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
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/test');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalaghaToc(
                          TypeId: 3,
                          title: 'حکم و مواعظ',
                          changeLocale: widget.changeLocale,
                        ),
                      ),
                    );
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
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/test');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalaghaToc(
                          TypeId: 4,
                          title: 'تشریح طلب کلام',
                          changeLocale: widget.changeLocale,
                        ),
                      ),
                    );
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
          ),
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
                onPressed: () {
                  Navigator.pushNamed(context, '/NotesView');
                },
                icon: const Icon(Icons.notes),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/BookmarksView');
                },
                icon: const Icon(Icons.bookmark),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Profile');
                },
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
