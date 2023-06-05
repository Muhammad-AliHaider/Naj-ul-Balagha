import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../NotesBloc.dart';
import '../NotesEvents.dart';
import '../NotesModel.dart';
import '../NotesStates.dart';
import '../Repo/NotesRepo.dart';

class NoteAdd extends StatefulWidget {
  final NotesRepo? repo;
  final FirebaseAuth? auth;
  const NoteAdd({Key? key, this.repo, this.auth}) : super(key: key);

  @override
  _NoteAddState createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User? user = (widget.auth == null
        ? FirebaseAuth.instance.currentUser
        : widget.auth!.currentUser);
    TextEditingController _titleController = TextEditingController();
    TextEditingController _contentController = TextEditingController();

    NotesRepo repository = (widget.repo == null ? NotesRepo() : widget.repo!);

    HandleAdd(context) {
      if (_formKey.currentState!.validate()) {
        BlocProvider.of<NotesBloc>(context).add(
          NotesAddEvent(
            title: _titleController.text,
            content: _contentController.text,
            uid: user!.uid,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
        shadowColor: Colors.grey.withOpacity(0.5),
        backgroundColor: Color.fromARGB(255, 65, 205, 149),
      ),
      body: BlocProvider(
        create: (context) => NotesBloc(repository: repository),
        child: BlocListener<NotesBloc, NotesStates>(
          listener: (context, state) {
            if (state is BlocMove) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Note Added'),
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, '/NotesView', ModalRoute.withName('/HomePage'));
            }
          },
          child: BlocBuilder<NotesBloc, NotesStates>(
            builder: (context, state) {
              if (state is BlocLoad) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is BlocInitial) {
                return Stack(
                  children: [
                    SizedBox(
                        child: Image.asset(
                      'assets/images/bg3.jpg',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    )),
                    ListView(
                      children: [
                        Image.asset('assets/images/Center_Noteadd_1.png'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Form(
                              key: _formKey,
                              child: Column(children: [
                                Card(
                                  child: TextFormField(
                                    controller: _titleController,
                                    decoration: InputDecoration(
                                      labelText: 'Title',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 139, 241, 200)),
                                      ),
                                      suffixIcon: const Icon(Icons.title),
                                      suffixIconColor: const Color.fromARGB(
                                          255, 139, 241, 200),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the Title';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: TextFormField(
                                    controller: _contentController,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      labelText: 'Content',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 139, 241, 200)),
                                      ),
                                      suffixIcon:
                                          const Icon(Icons.content_paste),
                                      suffixIconColor: const Color.fromARGB(
                                          255, 139, 241, 200),
                                    ),
                                    maxLines: 9,
                                    minLines: 9,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the Content';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ])),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10),
                          child: InkWell(
                              onTap: () {
                                // Update(context);
                                HandleAdd(context);
                              },
                              child: Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 65, 205, 149),
                                          Color.fromARGB(84, 73, 236, 192)
                                        ]),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'ADD',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )))),
                        )
                      ],
                    ),
                  ],
                );
              } else if (state is BlocError) {
                return const Center(
                  child: Text("Error"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
