import '../MuqadamatEvents.dart';
import '../MuqadamatModel.dart';
import '../MuqadamatStates.dart';
import '../Repo/MuqadamatRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../MuqadamatBloc.dart';

class PaishGhuftar extends StatefulWidget {
  const PaishGhuftar({Key? key}) : super(key: key);

  @override
  _PaishGhuftarState createState() => _PaishGhuftarState();
}

class _PaishGhuftarState extends State<PaishGhuftar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("پیش گفتار"),
        surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
        shadowColor: Colors.grey.withOpacity(0.5),
        backgroundColor: Color.fromARGB(255, 65, 205, 149),
      ),
      body: BlocProvider(
        create: (create) => MuqadamatBloc(repository: MuqadamatRepo())
          ..add(const MuqadamatReadEvent(Type: 1)),
        child: BlocBuilder<MuqadamatBloc, MuqadamatStates>(
          builder: (context, state) {
            if (state is BlocLoad) {
              return Stack(
                children: [
                  SizedBox(
                      child: Image.asset(
                    'assets/images/bg3.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  )),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
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
                  Card(
                    child: InteractiveViewer(
                      panEnabled: false, // Set it to false to prevent panning.
                      boundaryMargin: EdgeInsets.all(80),
                      minScale: 1,
                      maxScale: 4,
                      child: ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.data[index].mqar != null
                                      ? state.data[index].mqar as String
                                      : "",
                                  style: TextStyle(
                                      fontFamily: "Mohammdi", fontSize: 25),
                                ),
                                Text(
                                    state.data[index].mqur != null
                                        ? state.data[index].mqur as String
                                        : "",
                                    style: TextStyle(
                                        fontFamily: "Alvi", fontSize: 20)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is BlocError) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<MuqadamatBloc>(context)
                      .add(const MuqadamatReadEvent(Type: 1));
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
                    Center(
                      child: Text(state.message),
                    ),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<MuqadamatBloc>(context)
                      .add(const MuqadamatReadEvent(Type: 1));
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
                    Center(
                      child: Text("Something went wrong"),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
