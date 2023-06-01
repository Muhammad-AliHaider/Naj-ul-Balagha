import '../MuqadamatModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MuqadamatRepo {
  Future<List<MuqadamatModel>> ReadAll(int type) async {
    final List<MuqadamatModel> data = [];
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('balaghatext_muqadamat')
        .where('type', isEqualTo: type)
        .orderBy('id')
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((element) {
      final MuqadamatModel model = MuqadamatModel();
      model.fromJson(element.data() as Map<String, dynamic>);
      data.add(model);
    });
    return data;
  }
}
