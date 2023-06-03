import './HawashiEvent.dart';
import './HawashiState.dart';
import './HawashiModel.dart';
import './Repo/HawashiRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HawashiBloc extends Bloc<HawashiEvent, HawashiState> {
  final HawashiRepo repository;

  HawashiBloc({required this.repository}) : super(BlocLoad()) {
    on<HawashiEvent>((event, emit) async {
      emit(BlocLoad());

      try {
        if (event is HawashiReadAllEvent) {
          final List<HawashiModel> data = await repository.Read();
          print(data[0]);
          emit(BlocSuccess(data));
        }
      } catch (e) {
        print(e);
        emit(BlocError(e.toString()));
      }
    });
  }
}
