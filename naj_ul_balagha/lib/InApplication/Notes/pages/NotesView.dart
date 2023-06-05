import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naj_ul_balagha/InApplication/Notes/pages/NotesUpdate.dart';
import '../NotesBloc.dart';
import '../NotesEvents.dart';
import '../NotesModel.dart';
import '../NotesStates.dart';
import '../Repo/NotesRepo.dart';

class NotesView extends StatefulWidget {
  final Function(Locale) changeLocale;
  final NotesRepo? repo;
  final FirebaseAuth? auth;
  NotesView({Key? key, required this.changeLocale, this.auth, this.repo})
      : super(key: key);

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
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
    User? user = widget.auth == null
        ? FirebaseAuth.instance.currentUser
        : widget.auth!.currentUser;
    NotesRepo? repository = widget.repo == null ? NotesRepo() : widget.repo!;

    return BlocProvider(
        create: (context) => NotesBloc(repository: NotesRepo())
          ..add(readAllNotesEvent(uid: widget.auth == null ? user!.uid : "1")),
        child: BlocListener<NotesBloc, NotesStates>(
          listener: (context, state) {
            if (state is BlocMove) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Note Deleted'),
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, '/NotesView', ModalRoute.withName('/HomePage'));
            }
          },
          child: BlocBuilder<NotesBloc, NotesStates>(
            builder: (context, state) {
              if (state is BlocLoad) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Notes"),
                    surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    backgroundColor: Color.fromARGB(255, 65, 205, 149),
                  ),
                  body: Stack(
                    children: [
                      SizedBox(
                          child: Image.asset(
                        'assets/images/bg3.jpg',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )),
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                );
              } else if (state is BlocError) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Notes"),
                    surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    backgroundColor: Color.fromARGB(255, 65, 205, 149),
                  ),
                  body: Stack(
                    children: [
                      SizedBox(
                          child: Image.asset(
                        'assets/images/bg3.jpg',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )),
                      const Center(
                        child: Text("Error while fetching data, please Reload"),
                      ),
                    ],
                  ),
                );
              } else if (state is BlocSuccess) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Notes"),
                    surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    backgroundColor: Color.fromARGB(255, 65, 205, 149),
                  ),
                  body: RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<NotesBloc>(context).add(readAllNotesEvent(
                          uid: widget.auth == null ? user!.uid : "1"));
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                            child: Image.asset(
                          'assets/images/bg3.jpg',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        )),
                        if (state.data.isNotEmpty)
                          ListView.builder(
                              itemCount: state.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: ListTile(
                                  onLongPress: () {
                                    // add update event
                                    // print("asdasd0");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NoteUpdate(
                                          id: state.data[index].id!,
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(state.data[index].title != null
                                      ? state.data[index].title!
                                      : ""),
                                  subtitle: Text(
                                      state.data[index].content != null
                                          ? state.data[index].content!
                                          : ""),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext innercontext) {
                                            return AlertDialog(
                                              title: const Text("Delete Note"),
                                              content: const Text(
                                                  "Are you sure you want to delete this note?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          innercontext);
                                                    },
                                                    child:
                                                        const Text("Cancel")),
                                                TextButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  NotesBloc>(
                                                              context)
                                                          .add(NotesDeleteEvent(
                                                              id: state
                                                                  .data[index]
                                                                  .id!));
                                                      Navigator.pop(
                                                          innercontext);
                                                    },
                                                    child: const Text("Delete"))
                                              ],
                                            );
                                          });

                                      // BlocProvider.of<NotesBloc>(context).add(
                                      //     NotesDeleteEvent(
                                      //         id: state.data[index].id! ));
                                    },
                                  ),
                                ));
                              }),
                        if (state.data.isEmpty)
                          const Center(
                            child: Text("No Notes"),
                          ),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/NoteAdd');
                    },
                    child: const Icon(Icons.add),
                    backgroundColor: Color.fromARGB(255, 65, 205, 149),
                  ),
                );
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Notes"),
                    surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    backgroundColor: Color.fromARGB(255, 65, 205, 149),
                  ),
                  body: const Center(
                    child: Text("Something went wrong"),
                  ),
                );
              }
            },
          ),
        ));
  }
}
