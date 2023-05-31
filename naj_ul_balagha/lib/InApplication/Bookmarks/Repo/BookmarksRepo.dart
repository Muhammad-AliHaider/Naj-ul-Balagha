import 'package:cloud_firestore/cloud_firestore.dart';
import '../BookmarksModel.dart';

class BookmarksRepo {
  ReadAll({required String uid}) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Bookmarks');
    List<BookmarksModel> products = [];
    try {
      QuerySnapshot querySnapshot =
          await collectionReference.where('uid', isEqualTo: uid).get();
      querySnapshot.docs.forEach((element) {
        BookmarksModel product = BookmarksModel();
        product.fromJson(element.data() as Map<String, dynamic>);
        // print(element.data());
        print(product.Description);
        product.id = element.id;
        products.add(product);
      });
    } catch (error) {
      print("Failed to Read data: $error");
    }
    return products;
  }

  // int? typeNo;
  // int? typeid;
  // String? Description;
  // String? uid;
  // int? id;

  AddBookmark(
      {required int? typeNo,
      required int? typeid,
      required String? Description,
      required String? uid,
      required int? totaltypeNo}) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Bookmarks');
    try {
      collectionReference.add({
        'typeNo': typeNo,
        'typeid': typeid,
        'description': Description,
        'uid': uid,
        'totaltypeNo': totaltypeNo
      });
    } catch (error) {
      print("Failed to Add data: $error");
    }
  }

  DeleteBookmark({required String? id}) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Bookmarks');
    try {
      collectionReference.doc(id).delete();
    } catch (error) {
      print("Failed to Delete data: $error");
    }
  }
}
