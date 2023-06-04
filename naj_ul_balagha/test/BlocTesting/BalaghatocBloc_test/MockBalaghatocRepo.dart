import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_toc/Repo/balaghatocRepo.dart';
import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_toc/balaghatocModel.dart';

List<BalaghatocModel> mockData = [
  BalaghatocModel(
    typeNo: 1,
    typeid: 1,
    Description: "Test Content 1",
  ),
  BalaghatocModel(
    typeNo: 1,
    typeid: 2,
    Description: "Test Content 2",
  ),
  BalaghatocModel(
    typeNo: 2,
    typeid: 3,
    Description: "Test Content 3",
  ),
  BalaghatocModel(
    typeNo: 3,
    typeid: 3,
    Description: "Test Content 4",
  ),
];

class MockBalaghatocRepo implements BalaghatocRepo {
  @override
  Read(int TypeId) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return mockData.where((element) => element.typeid == TypeId).toList();
    });
  }
}
