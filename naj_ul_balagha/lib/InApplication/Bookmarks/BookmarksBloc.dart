import 'BookmarksEvents.dart';
import 'BookmarksModel.dart';
import 'Repo/BookmarksRepo.dart';
import 'BookmarksStates.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarkStates> {
  final BookmarksRepo repository;

  BookmarksBloc({required this.repository}) : super(BookmarkBlocInitial()) {
    on<BookmarksEvent>((event, emit) async {
      emit(BookmarkBlocLoad());

      try {
        if (event is BookMarksReadAllEvent) {
          final List<BookmarksModel> data =
              await repository.ReadAll(uid: event.uid);
          // print(data[0].typeNo);
          emit(BookmarkBlocSuccess(data));
        }
        if (event is AddBookmarksEvent) {
          emit(BookmarkBlocLoad());
          await repository.AddBookmark(
              typeNo: event.typeNo,
              typeid: event.typeid,
              Description: event.Description,
              uid: event.uid,
              totaltypeNo: event.totaltypeNo);
          // print(data[0].typeNo);
          emit(const BookmarkBlocMove());
        }
        if (event is DeleteBookmarksEvent) {
          await repository.DeleteBookmark(id: event.id);
          // print(data[0].typeNo);
          emit(BookmarkBlocMove());
        }
      } catch (e) {
        print(e);
        emit(BookmarkBlocError(e.toString()));
      }
    });
  }
}
