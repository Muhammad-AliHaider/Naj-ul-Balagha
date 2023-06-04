import 'package:naj_ul_balagha/OnBoarding/bloc/UserRepo.dart';
import 'package:naj_ul_balagha/OnBoarding/bloc/UserModel.dart';

List<UserModel> MockData = <UserModel>[
  UserModel(
      Email: "Acdefgh@gmail.com",
      Password: "123456",
      UserName: "Ahmed",
      BirthDate: "2023-05-24",
      uid: "1"),
  UserModel(
      Email: "johndoe@gmail.com",
      Password: "password123",
      UserName: "John Doe",
      BirthDate: "1990-07-15",
      uid: "2"),
  UserModel(
      Email: "testuser@example.com",
      Password: "testpass789",
      UserName: "Test User",
      BirthDate: "1995-03-10",
      uid: "3"),
];

class MockUserRepository implements UserRepo {
  @override
  AddUser(Email, Password, UserName, BirthDate, String uid) async {
    Future.delayed(
        const Duration(seconds: 2),
        () => MockData.add(UserModel(
            Email: Email,
            Password: Password,
            UserName: UserName,
            BirthDate: BirthDate,
            uid: uid)));
  }

  @override
  Delete_User(uid) async {
    Future.delayed(const Duration(seconds: 2),
        () => MockData.removeWhere((element) => element.uid == uid));
  }

  @override
  Future<UserModel> Read_User(uid) async => await Future.delayed(
      const Duration(seconds: 2),
      () => MockData.firstWhere((element) => element.uid == uid));

  @override
  Future<List<UserModel>> ReadAllUser() async {
    return Future.delayed(const Duration(seconds: 2), () => MockData);
  }

  // UpdateUser(Email, Password, UserName, BirthDate, id)

  @override
  UpdateUser(Email, Password, UserName, BirthDate, id) async {
    Future.delayed(
        const Duration(seconds: 2),
        () =>
            MockData.firstWhere((element) => element.uid == id).Email = Email);
    Future.delayed(
        const Duration(seconds: 2),
        () => MockData.firstWhere((element) => element.uid == id).Password =
            Password);
    Future.delayed(
        const Duration(seconds: 2),
        () => MockData.firstWhere((element) => element.uid == id).UserName =
            UserName);
    Future.delayed(
        const Duration(seconds: 2),
        () => MockData.firstWhere((element) => element.uid == id).BirthDate =
            BirthDate);
  }
}
