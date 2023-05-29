import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_language_fonts/google_language_fonts.dart';

import './Bloc_Balagha_text/BalaghatextEvents.dart';
import './Bloc_Balagha_text/BalaghatextStates.dart';
import './Bloc_Balagha_text/BalaghatextBloc.dart';
import './Bloc_Balagha_text/BalaghatextRepo/BalaghatextRepo.dart';

class ReadingPage extends StatefulWidget {
  final int Type;
  final int TypeNo;
  final String title;
  const ReadingPage(
      {Key? key, required this.Type, required this.TypeNo, required this.title})
      : super(key: key);
  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  static User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
              icon: Icon(Icons.arrow_back),
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
                title: const Text('Page 1'),
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/HomePage'));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(),
            ],
          ),
        ),
        body: BlocProvider(
            create: (context) => BalaghaTextBloc(repository: BalaghaTextRepo())
              ..add(textReadEvent(Type: widget.Type, TypeNo: widget.TypeNo)),
            child: BlocBuilder<BalaghaTextBloc, textStateBloc>(
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
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(state.data[index].AR.toString(),
                                    style: ArabicFonts.mirza(fontSize: 25)),
                                subtitle: Text(
                                    state.data[index].UR != null
                                        ? state.data[index].UR.toString()
                                        : '',
                                    style: ArabicFonts.amiri(fontSize: 15)),
                              ),
                            );
                          },
                        ),
                      ),
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
