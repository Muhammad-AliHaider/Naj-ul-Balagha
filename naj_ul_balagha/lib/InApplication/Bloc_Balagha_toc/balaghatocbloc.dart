import 'balaghatocModel.dart';
import 'balaghatocEvents.dart';
import 'balaghatocStates.dart';
import 'Repo/balaghatocRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class balaghaBloc extends Bloc<tocEvent, tocStateBloc> {
  final BalaghatocRepo repository;

  balaghaBloc({required this.repository}) : super(BlocLoad()) {
    on<tocEvent>((event, emit) async {
      emit(BlocLoad());

      try {
        if (event is tocReadEvent) {
          final List<BalaghatocModel> data =
              await repository.Read(event.TypeId);
          print(data[0].typeNo);
          emit(BlocSuccess(data));
        }
      } catch (e) {
        print(e);
        emit(BlocError(e.toString()));
      }
    });
  }
}
