import 'package:naj_ul_balagha/InApplication/Bookmarks/BookmarksModel.dart';
import 'package:naj_ul_balagha/InApplication/Bookmarks/Repo/BookmarksRepo.dart';

// int? typeNo;
//   int? typeid;
//   String? Description;
//   String? uid;
//   String? id;
//   int? totaltypeNo;

List<BookmarksModel> mockData = [
  BookmarksModel(
    typeNo: 1,
    typeid: 1,
    Description: "Test Content 1",
    uid: "1",
    totaltypeNo: 1,
  ),
  BookmarksModel(
    typeNo: 2,
    typeid: 2,
    Description: "Test Content 2",
    uid: "2",
    totaltypeNo: 2,
  ),
  BookmarksModel(
    typeNo: 3,
    typeid: 3,
    Description: "Test Content 3",
    uid: "3",
    totaltypeNo: 3,
  ),
  BookmarksModel(
    typeNo: 3,
    typeid: 3,
    Description: "Test Content 3",
    uid: "4",
    totaltypeNo: 3,
  ),
];

class MockBookmarkRepo implements BookmarksRepo {
  @override
  AddBookmark(
      {String? uid,
      int? typeNo,
      int? typeid,
      String? Description,
      int? totaltypeNo}) {
    Future.delayed(const Duration(seconds: 2), () {
      mockData.add(BookmarksModel(
        typeNo: typeNo,
        typeid: typeid,
        Description: Description,
        uid: uid,
        totaltypeNo: totaltypeNo,
      ));
    });
  }

  @override
  DeleteBookmark({required String? id}) async {
    Future.delayed(const Duration(seconds: 2), () {
      mockData.removeWhere((element) => element.id == id);
    });
  }

  @override
  Future<BookmarksModel> ReadBookmark(String id) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return mockData.firstWhere((element) => element.id == id);
    });
  }

  @override
  ReadAll({String? uid}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      List<BookmarksModel> x =
          mockData.where((element) => element.uid == uid).toList();
      for (int i = 0; i < x.length; i++) {
        // print(mockData[i].title);
        x[i].id = i.toString();
      }
      return x;
    });
  }
}
