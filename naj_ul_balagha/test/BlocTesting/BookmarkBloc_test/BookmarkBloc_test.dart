import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:naj_ul_balagha/InApplication/Bookmarks/BookmarksBloc.dart';
import 'package:naj_ul_balagha/InApplication/Bookmarks/BookmarksEvents.dart';
import 'package:naj_ul_balagha/InApplication/Bookmarks/BookmarksStates.dart';

import 'MockBookmarkRepo.dart';

void main() {
  group("Bookmark Test", () {
    late BookmarksBloc bookmarkBloc;
    late MockBookmarkRepo mockBookmarkRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockBookmarkRepo = MockBookmarkRepo();
      bookmarkBloc = BookmarksBloc(repository: mockBookmarkRepo);
    });

    blocTest<BookmarksBloc, BookmarkStates>(
      "test for Read success",
      build: () => bookmarkBloc,
      act: (bloc) {
        bloc.add(BookMarksReadAllEvent(uid: '3'));
      },
      wait: const Duration(seconds: 2),
      expect: () => [isA<BookmarkBlocLoad>(), isA<BookmarkBlocSuccess>()],
    );

    blocTest<BookmarksBloc, BookmarkStates>(
      "test for Add success",
      build: () => bookmarkBloc,
      act: (bloc) {
        bloc.add(AddBookmarksEvent(
            typeNo: 3,
            typeid: 4,
            Description: "Test Content 456",
            uid: "54",
            totaltypeNo: 7));
      },
      wait: const Duration(seconds: 2),
      expect: () => [isA<BookmarkBlocLoad>(), isA<BookmarkBlocMove>()],
    );

    blocTest<BookmarksBloc, BookmarkStates>(
      "test for Delete success",
      build: () => bookmarkBloc,
      act: (bloc) {
        bloc.add(DeleteBookmarksEvent(id: "1"));
      },
      wait: const Duration(seconds: 2),
      expect: () => [isA<BookmarkBlocLoad>(), isA<BookmarkBlocMove>()],
    );

    // error state
    blocTest<BookmarksBloc, BookmarkStates>(
      "test for Read error",
      build: () => bookmarkBloc,
      act: (bloc) {
        bloc.add(BookMarksReadAllEvent(uid: '1005684'));
      },
      wait: const Duration(seconds: 2),
      expect: () => [isA<BookmarkBlocLoad>(), isA<BookmarkBlocError>()],
    );

    tearDown(() async {
      await bookmarkBloc.close();
    });
  });
}
