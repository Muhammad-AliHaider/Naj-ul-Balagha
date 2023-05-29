import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc_Balagha_toc/Repo/balaghatocRepo.dart';
import 'Bloc_Balagha_toc/balaghatocbloc.dart';
import 'Bloc_Balagha_toc/balaghatocEvents.dart';
import 'Bloc_Balagha_toc/balaghatocStates.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BalaghaToc extends StatefulWidget {
  final int TypeId;
  final String title;
  const BalaghaToc({Key? key, required this.TypeId, required this.title})
      : super(key: key);

  @override
  _BalaghaTocState createState() => _BalaghaTocState();
}

class _BalaghaTocState extends State<BalaghaToc> {
  static User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => balaghaBloc(repository: BalaghatocRepo())
        ..add(tocReadEvent(TypeId: widget.TypeId)),
      child: BlocBuilder<balaghaBloc, tocStateBloc>(
        builder: (context, state) {
          if (state is BlocLoad) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is BlocSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
                shadowColor: Colors.grey.withOpacity(0.5),
                backgroundColor: Color.fromARGB(255, 65, 205, 149),
              ),
              drawer: Drawer(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      // <-- SEE HERE
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 65, 205, 149)),
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
                        Navigator.popUntil(
                            context, ModalRoute.withName('/HomePage'));
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
              body: Stack(
                children: [
                  Image.asset(
                    'assets/images/bg3.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(state.data[index].Description as String),
                          onTap: () {
                            // Navigator.pushNamed(context, '/balagha',
                            //     arguments: state.data[index].Id);
                          },
                          leading: Text(state.data[index].typeNo.toString()),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is BlocError) {
            return Scaffold(
              body: Center(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}
