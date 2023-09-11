import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../OnBoarding/bloc/UserBloc.dart';
import '../OnBoarding/bloc/UserEvents.dart';
import '../OnBoarding/bloc/UserStates.dart';
import '../OnBoarding/bloc/UserRepo.dart';

class Profile extends StatefulWidget {
  final Function(Locale) changeLocale;
  final UserRepo? repo;
  final FirebaseAuth? auth;
  const Profile({Key? key, required this.changeLocale, this.repo, this.auth})
      : super(key: key);

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initLocale();
    });
  }

  Future<void> _initLocale() async {
    await Future.delayed(Duration.zero); // Delay execution until after build
    widget.changeLocale(const Locale('en', 'US')); // Change to French locale
    setState(() {}); // Rebuild the widget
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth =
        (widget.auth == null ? FirebaseAuth.instance : widget.auth!);
    User? user = _auth.currentUser;
    UserRepo repository = (widget.repo == null ? UserRepo() : widget.repo!);

    HandleDelete(context, uid) async {
      try {
        await _auth.currentUser?.delete();
        BlocProvider.of<UserBloc>(context).add(userDelete_Event(uid: uid));
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error"),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
        shadowColor: Colors.grey.withOpacity(0.5),
        backgroundColor: Color.fromARGB(255, 65, 205, 149),
      ),
      body: BlocProvider(
        create: (create) => UserBloc(repository),
        child: BlocListener<UserBloc, StateBlock>(
          listener: (context, state) => {
            if (state is BlocSuccess)
              {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false)
              }
          },
          child: Builder(builder: (context) {
            return Stack(
              children: [
                SizedBox(
                    child: Image.asset(
                  'assets/images/bg3.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                )),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          'assets/images/muslim.png',
                        ),
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.width * 0.65,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/test');
                            Navigator.pushNamed(context, '/UpdateUser');
                          },
                          child: Text(
                            'Update Profile',
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 65, 205, 149),
                            minimumSize: Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/test');
                            // HandleDelete(context, user!.uid);
                            showDialog(
                                context: context,
                                builder: (BuildContext innercontext) {
                                  return AlertDialog(
                                    title: Text("Delete Account"),
                                    content: Text(
                                        "Are you sure you want to delete your account?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(innercontext);
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          HandleDelete(context, user?.uid);
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            'Delete Account',
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 65, 205, 149),
                            minimumSize: Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/test');
                            _auth.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/", (route) => false);
                          },
                          child: Text(
                            'Sign Out',
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 65, 205, 149),
                            minimumSize: Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
