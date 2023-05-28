import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'UserModel.dart';

class UserRepo {
  AddUser(Email, Password, UserName, BirthDate, String uid) async {
    UserModel user = UserModel(
        Email: Email,
        Password: Password,
        UserName: UserName,
        BirthDate: BirthDate,
        uid: uid);

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    DocumentReference userDocRef = usersCollection.doc(uid);
    userDocRef
        .set(user.toJson(), SetOptions(merge: true))
        .then((value) => print("Data set successfully"))
        .catchError((error) => print("Failed to set data: $error"));
  }

  Delete_User(String uid) {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    DocumentReference userDocRef = usersCollection.doc(uid);
    userDocRef
        .delete()
        .then((value) => print("Data Deleted successfully"))
        .catchError((error) => print("Failed to Delete data: $error"));
  }

  Future<UserModel> Read_User(String uid) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    DocumentReference userDocRef = usersCollection.doc(uid);
    UserModel user = UserModel();
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

  Future<List<UserModel>> ReadAllUser() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Users');
    List<UserModel> products = [];
    try {
      QuerySnapshot querySnapshot = await collectionReference.get();
      querySnapshot.docs.forEach((element) {
        UserModel product = UserModel();
        product.fromJson(element.data() as Map<String, dynamic>);
        product.uid = element.id;
        products.add(product);
      });
    } catch (error) {
      print("Failed to Read data: $error");
    }
    return products;
  }

  UpdateUser(Email, Password, UserName, BirthDate, id) async {
    UserModel user = UserModel(
        Email: Email,
        Password: Password,
        UserName: UserName,
        BirthDate: BirthDate);

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    DocumentReference userDocRef = usersCollection.doc(id);
    userDocRef
        .set(user.toJson(), SetOptions(merge: true))
        .then((value) => print("Data set successfully"))
        .catchError((error) => print("Failed to set data: $error"));
  }
}
