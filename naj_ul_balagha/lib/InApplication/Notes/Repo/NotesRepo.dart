import "package:cloud_firestore/cloud_firestore.dart";

import "../NotesModel.dart";

class NotesRepo {
  ReadAllNotes(String uid) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Notes');
    List<NotesModel> products = [];
    try {
      QuerySnapshot querySnapshot =
          await collectionReference.where('uid', isEqualTo: uid).get();
      print(querySnapshot.docs.length);
      querySnapshot.docs.forEach((element) {
        NotesModel product = NotesModel();
        product.fromJson(element.data() as Map<String, dynamic>);
        // print(element.data());
        print(product.content);
        product.id = element.id;
        products.add(product);
      });
    } catch (error) {
      print("Failed to Read data: $error");
    }
    return products;
  }

  Future<NotesModel> ReadNote(String id) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Notes');
    DocumentReference userDocRef = usersCollection.doc(id);
    NotesModel user = NotesModel();
    try {
      DocumentSnapshot userSnapshot = await userDocRef.get();
      if (userSnapshot.exists) {
        user.fromJson(userSnapshot.data() as Map<String, dynamic>);
        print("Data Read successfully");
      } else {
        print("No such user");
      }
    } catch (error) {
      print("Failed to Read data: $error");
    }
    return user;
  }

  AddNote(String uid, String title, String content) async {
    NotesModel user = NotesModel(title: title, content: content, uid: uid);

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Notes');
    await usersCollection.add({
      "uid": uid,
      "title": title,
      "content": content,
    });
  }

  DeleteNote(String id) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Notes');

    await usersCollection.doc(id).delete();
  }

  UpdateNote(String uid, String title, String content, String id) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Notes');

    await usersCollection.doc(id).update({
      "uid": uid,
      "title": title,
      "content": content,
    });
  }
}
