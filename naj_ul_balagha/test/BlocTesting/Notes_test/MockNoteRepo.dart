// String? title;
//   String? content;
//   String? uid;
//   String? id;

import 'package:naj_ul_balagha/InApplication/Notes/NotesModel.dart';
import 'package:naj_ul_balagha/InApplication/Notes/Repo/NotesRepo.dart';

List<NotesModel> mockData = [
  NotesModel(
    title: "Test Title 1",
    content: "Test Content 1",
    uid: "1",
  ),
  NotesModel(
    title: "Test Title 2",
    content: "Test Content 2",
    uid: "2",
  ),
  NotesModel(
    title: "Test Title 3",
    content: "Test Content 3",
    uid: "3",
  ),
];

class MockNoteRepo implements NotesRepo {
  @override
  AddNote(String uid, String title, String content) async {
    Future.delayed(const Duration(seconds: 2), () {
      mockData.add(NotesModel(
        title: title,
        content: content,
        uid: uid,
      ));
    });
  }

  @override
  DeleteNote(String id) async {
    Future.delayed(const Duration(seconds: 2), () {
      mockData.removeWhere((element) => element.id == id);
    });
  }

  @override
  Future<NotesModel> ReadNote(String id) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return mockData.firstWhere((element) => element.id == id);
    });
  }

  @override
  ReadAllNotes(String uid) async {
    return Future.delayed(const Duration(seconds: 2), () {
      mockData.where((element) => element.uid == uid).toList();
      for (int i = 0; i < mockData.length; i++) {
        // print(mockData[i].title);
        mockData[i].id = i.toString();
      }
      return mockData;
    });
  }

  @override
  UpdateNote(String uid, String title, String content, String id) async {
    Future.delayed(const Duration(seconds: 2), () {
      mockData.removeWhere((element) => element.id == id);
      mockData.add(NotesModel(
        title: title,
        content: content,
        uid: uid,
      ));
    });
  }
}
