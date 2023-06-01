import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_language_fonts/google_language_fonts.dart';

import '../MuqadamatBloc.dart';
import '../Repo/MuqadamatRepo.dart';
import '../MuqadamatModel.dart';
import '../MuqadamatStates.dart';
import '../MuqadamatEvents.dart';

class RPHurf extends StatefulWidget {
  final int Type;
  // final String title;
  final int totalTypeNo;
  const RPHurf({Key? key, required this.Type, required this.totalTypeNo})
      : super(key: key);
  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<RPHurf> {
  static User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('حرف آغاز'),
          surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
          shadowColor: Colors.grey.withOpacity(0.5),
          backgroundColor: Color.fromARGB(255, 65, 205, 149),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.popUntil(context, (route) => route.isFirst);
                // FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_forward),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                // <-- SEE HERE
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 65, 205, 149)),
                accountName: Text(user!.displayName.toString()),
                accountEmail: Text(
                  user!.email.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "P",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Home'),
                onTap: () {
                  // Navigator.popUntil(context, ModalRoute.withName('/HomePage'));
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/HomePage', (route) => false);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.person,
                ),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/Profile', ModalRoute.withName('/HomePage'));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.auto_stories_rounded,
                ),
                title: const Text('پیش گفتار'),
                onTap: () {
                  Navigator.pushNamed(context, '/PaishGhuftar');
                },
              ),
              Divider(),
            ],
          ),
        ),
        body: BlocProvider(
            create: (context) => MuqadamatBloc(repository: MuqadamatRepo())
              ..add(MuqadamatReadEvent(Type: widget.Type)),
            child: BlocBuilder<MuqadamatBloc, MuqadamatStates>(
              builder: (context, state) {
                if (state is BlocLoad) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is BlocError) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Error'),
                    ),
                  );
                } else if (state is BlocSuccess) {
                  return Stack(
                    children: [
                      SizedBox(
                          child: Image.asset(
                        'assets/images/bg3.jpg',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )),
                      InteractiveViewer(
                        panEnabled:
                            false, // Set it to false to prevent panning.
                        boundaryMargin: EdgeInsets.all(80),
                        minScale: 1,
                        maxScale: 4,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 50),
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        state.data[index].mqar != null
                                            ? state.data[index].mqar.toString()
                                            : '',
                                        style: TextStyle(
                                            fontFamily: 'Mohammdi',
                                            fontSize: 20),
                                        textAlign: TextAlign.justify),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        state.data[index].mqur != null
                                            ? state.data[index].mqur.toString()
                                            : '',
                                        style: TextStyle(
                                            fontFamily: 'Alvi', fontSize: 20),
                                        textAlign: TextAlign.justify),
                                  ],
                                ),
                              )),
                            );
                          },
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.07,
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
                          )),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                              iconSize: 50,
                              onPressed: () {
                                if (widget.Type < widget.totalTypeNo) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RPHurf(
                                        Type: widget.Type + 1,
                                        totalTypeNo: widget.totalTypeNo,
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(Icons.arrow_right))),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                              iconSize: 50,
                              onPressed: () {
                                if (widget.Type > 3) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RPHurf(
                                        Type: widget.Type - 1,
                                        totalTypeNo: widget.totalTypeNo,
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(Icons.arrow_left))),
                    ],
                  );
                } else {
                  return const Scaffold(
                    body: Center(
                      child: Text('SomeThing Went Wrong'),
                    ),
                  );
                }
              },
            )));
  }
}
