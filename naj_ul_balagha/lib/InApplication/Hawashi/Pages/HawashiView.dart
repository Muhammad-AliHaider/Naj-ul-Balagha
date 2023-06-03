import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../HawashiBloc.dart';
import '../HawashiEvent.dart';
import '../HawashiModel.dart';
import '../HawashiState.dart';
import '../Repo/HawashiRepo.dart';

class HawashiView extends StatefulWidget {
  const HawashiView({Key? key}) : super(key: key);

  @override
  _HawashiViewState createState() => _HawashiViewState();
}

class _HawashiViewState extends State<HawashiView> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "حواشی",
        ),
        surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
        shadowColor: Colors.grey.withOpacity(0.5),
        backgroundColor: Color.fromARGB(255, 65, 205, 149),
      ),
      body: BlocProvider(
        create: (context) =>
            HawashiBloc(repository: HawashiRepo())..add(HawashiReadAllEvent()),
        child: BlocBuilder<HawashiBloc, HawashiState>(
          builder: (context, state) {
            if (state is BlocLoad) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BlocError) {
              return Center(
                child: Text("Error: ${state.message}"),
              );
            } else if (state is BlocSuccess) {
              return Stack(
                children: [
                  Image.asset(
                    'assets/images/bg3.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Center(
                    child: Card(
                        child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(
                              state.data[index].hawashi != null
                                  ? state.data[index].hawashi!
                                  : '',
                              style: const TextStyle(
                                fontFamily: 'Alvi',
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                    )),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
