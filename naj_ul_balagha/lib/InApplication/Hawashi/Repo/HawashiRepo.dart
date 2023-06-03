import 'package:cloud_firestore/cloud_firestore.dart';
import '../HawashiModel.dart';

class HawashiRepo {
  Future<List<HawashiModel>> Read() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('balaghatext_hawashi')
            .orderBy("id")
            .get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        querySnapshot.docs;
    final List<HawashiModel> data = <HawashiModel>[];
    for (final QueryDocumentSnapshot<Map<String, dynamic>> element in docs) {
      data.add(HawashiModel.fromJson(element.data()));
    }
    return data;
  }
}
