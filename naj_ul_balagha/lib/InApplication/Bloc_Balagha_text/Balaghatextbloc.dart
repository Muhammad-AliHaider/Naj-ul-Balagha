import 'BalaghatextEvents.dart';
import 'BalaghatextModel.dart';
import 'BalaghatextRepo/BalaghatextRepo.dart';
import 'BalaghatextStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalaghaTextBloc extends Bloc<textEvent, textStateBloc> {
  final BalaghaTextRepo repository;
  // BalagahaTextRepo

  BalaghaTextBloc({required this.repository}) : super(BlocLoad()) {
    on<textEvent>((event, emit) async {
      emit(BlocLoad());

      try {
        if (event is textReadEvent) {
          final List<BalaghatextModel> data =
              await repository.Read(event.Type, event.TypeNo);
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
