import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_text/BalaghatextModel.dart';

import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_text/BalaghatextRepo/BalaghatextRepo.dart';

List<BalaghatextModel> MockData = [
  BalaghatextModel(
      id: 1, type: 1, typeNo: 1, AR: "الله", UR: "Allah", ARsimple: "الله"),
  BalaghatextModel(
      id: 2,
      type: 1,
      typeNo: 2,
      AR: "الرحمن",
      UR: "Al-Rahman",
      ARsimple: "الرحمن"),
  BalaghatextModel(
      id: 3,
      type: 1,
      typeNo: 3,
      AR: "الرحيم",
      UR: "Al-Raheem",
      ARsimple: "الرحيم"),
  BalaghatextModel(
      id: 4,
      type: 1,
      typeNo: 4,
      AR: "الملك",
      UR: "Al-Malik",
      ARsimple: "الملك"),
  BalaghatextModel(
      id: 5,
      type: 1,
      typeNo: 1,
      AR: "القدوس",
      UR: "Al-Quddus",
      ARsimple: "القدوس"),
];

class MockBalaghaTextRepo implements BalaghaTextRepo {
  @override
  Read(int Type, int TypeNo) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return MockData.where(
              (element) => element.type == Type && element.typeNo == TypeNo)
          .toList();
    });
  }
}
