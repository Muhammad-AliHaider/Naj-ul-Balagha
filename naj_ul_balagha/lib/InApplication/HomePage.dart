import 'package:flutter/material.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_toc/Pages/IndexedPage.dart';
import 'package:naj_ul_balagha/InApplication/Settings_constants.dart';

class HomePage extends StatefulWidget {
  final Function(Locale) changeLocale;
  final Settings_Constants FontSizes;
  const HomePage(
      {Key? key, required this.changeLocale, required this.FontSizes})
      : super(key: key);

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
              const Center(
                child: Text('نهج البلاغة',
                    // style: ArabicFonts.reemKufi(
                    //   textStyle: TextStyle(fontSize: 50),
                    //   color: Color.fromARGB(255, 65, 205, 149),
                    // ),
                    // style: ArabicFonts.amiri(
                    //   textStyle: TextStyle(fontSize: 50),
                    //   color: Color.fromARGB(255, 65, 205, 149),
                    // ),
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 50,
                      color: Color.fromARGB(255, 65, 205, 149),
                    )),
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
                  key: ValueKey('button1'),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/test');
                    // print("Button Daba");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalaghaToc(
                          TypeId: 5,
                          title: 'حرف آغاز',
                          changeLocale: widget.changeLocale,
                          FontSize: widget.FontSizes,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 65, 205, 149),
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'حرف آغاز',
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  key: ValueKey('button2'),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/test');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalaghaToc(
                          TypeId: 1,
                          title: 'خطبات',
                          changeLocale: widget.changeLocale,
                          FontSize: widget.FontSizes,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 65, 205, 149),
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'خطبات',
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  key: ValueKey('button3'),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/test');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalaghaToc(
                          TypeId: 2,
                          title: 'مکتوبات',
                          changeLocale: widget.changeLocale,
                          FontSize: widget.FontSizes,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 65, 205, 149),
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'مکتوبات',
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  key: ValueKey('button4'),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/test');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalaghaToc(
                          TypeId: 3,
                          title: 'حکم و مواعظ',
                          changeLocale: widget.changeLocale,
                          FontSize: widget.FontSizes,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 65, 205, 149),
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'حکم و مواعظ',
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  key: ValueKey('button5'),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/test');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalaghaToc(
                          TypeId: 4,
                          title: 'تشریح طلب کلام',
                          changeLocale: widget.changeLocale,
                          FontSize: widget.FontSizes,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 65, 205, 149),
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'تشریح طلب کلام',
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 30,
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
            gradient: const LinearGradient(
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
                key: ValueKey('NotesButton'),
                onPressed: () {
                  Navigator.pushNamed(context, '/NotesView');
                },
                icon: const Icon(Icons.notes),
              ),
              IconButton(
                key: ValueKey('BookmarksButton'),
                onPressed: () {
                  Navigator.pushNamed(context, '/BookmarksView');
                },
                icon: const Icon(Icons.bookmark),
              ),
              IconButton(
                key: ValueKey('ProfileButton'),
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
