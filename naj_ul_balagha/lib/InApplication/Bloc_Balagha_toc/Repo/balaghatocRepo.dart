import 'package:cloud_firestore/cloud_firestore.dart';
import '../balaghatocModel.dart';

class BalaghatocRepo {
  Read(int Typeid) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('balaghatoc');
    List<BalaghatocModel> products = [];
    try {
      QuerySnapshot querySnapshot = await collectionReference
          .where('typeid', isEqualTo: Typeid)
          .orderBy('id')
          .get();
      querySnapshot.docs.forEach((element) {
        BalaghatocModel product = BalaghatocModel();
        product.fromJson(element.data() as Map<String, dynamic>);
        // print(element.data());
        print(product.Description);
        // product.id = element.id as int;
        products.add(product);
      });
    } catch (error) {
      print("Failed to Read data: $error");
    }
    return products;
  }
}
