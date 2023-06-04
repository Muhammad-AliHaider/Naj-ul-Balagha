import 'package:naj_ul_balagha/InApplication/Hawashi/HawashiModel.dart';
import 'package:naj_ul_balagha/InApplication/Hawashi/Repo/HawashiRepo.dart';

List<HawashiModel> mockData = [
  HawashiModel(hawashi: "abcd"),
  HawashiModel(hawashi: "abcde"),
  HawashiModel(hawashi: "abcdf"),
  HawashiModel(hawashi: "abcdg"),
];

class MockHawashiRepo implements HawashiRepo {
  @override
  Read() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return mockData;
    });
  }
}
