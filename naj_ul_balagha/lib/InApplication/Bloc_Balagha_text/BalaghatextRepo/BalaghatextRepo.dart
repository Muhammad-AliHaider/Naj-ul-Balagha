import 'package:cloud_firestore/cloud_firestore.dart';
import '../BalaghatextModel.dart';

class BalaghaTextRepo {
  Read(int Type, int TypeNo) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('balaghatext');
    List<BalaghatextModel> products = [];
    try {
      QuerySnapshot querySnapshot = await collectionReference
          .where('type', isEqualTo: Type)
          .where('typeNo',
              isEqualTo: TypeNo) // type number is id of balagha toc
          .orderBy('id')
          .get();
      querySnapshot.docs.forEach((element) {
        BalaghatextModel product = BalaghatextModel();
        product.fromJson(element.data() as Map<String, dynamic>);
        // print(element.data());
        print(product.AR);
        // product.id = element.id as int;
        products.add(product);
      });
    } catch (error) {
      print("Failed to Read data: $error");
    }
    return products;
  }
}
