import 'package:naj_ul_balagha/InApplication/Muqadmat/MuqadamatModel.dart';
import 'package:naj_ul_balagha/InApplication/Muqadmat/Repo/MuqadamatRepo.dart';

List<MuqadamatModel> mockData = [
  MuqadamatModel(mqar: "مقدمة الكتاب الأول", mqur: "Asawf", type: 1, id: 2),
  MuqadamatModel(
      mqar: "مقدمة الكتاب الثاني", mqur: "Asawasdasf", type: 3, id: 2),
  MuqadamatModel(
      mqar: "مقدمة الكتاب الثالث", mqur: "Asafgdfgfdwf", type: 3, id: 2),
];

class MockMuqadamatRepo implements MuqadamatRepo {
  @override
  Future<List<MuqadamatModel>> ReadAll(int type) {
    return Future.delayed(const Duration(seconds: 2), () {
      return mockData.where((element) => element.type == type).toList();
    });
  }
}
