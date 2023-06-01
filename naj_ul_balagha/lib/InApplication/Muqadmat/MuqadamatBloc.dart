import 'package:flutter_bloc/flutter_bloc.dart';

import 'MuqadamatEvents.dart';
import 'MuqadamatModel.dart';
import 'MuqadamatStates.dart';
import './Repo/MuqadamatRepo.dart';

class MuqadamatBloc extends Bloc<MuqadamatEvent, MuqadamatStates> {
  final MuqadamatRepo repository;

  MuqadamatBloc({required this.repository}) : super(BlocLoad()) {
    on<MuqadamatEvent>((event, emit) async {
      emit(BlocLoad());

      try {
        if (event is MuqadamatReadEvent) {
          final List<MuqadamatModel> data =
              await repository.ReadAll(event.Type);
          print(data[0].id);
          emit(BlocSuccess(data));
        }
      } catch (e) {
        print(e);
        emit(BlocError(e.toString()));
      }
    });
  }
}
