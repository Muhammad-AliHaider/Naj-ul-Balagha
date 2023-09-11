import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  final ValueChanged<Locale> changeLocale;
  const Login({Key? key, required this.changeLocale}) : super(key: key);
  static const String routeName = '/Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const String routeName = '/Login';

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
    return Scaffold(body: mybody(context));
  }

  Widget mybody(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    TextEditingController? emailController = TextEditingController();
    TextEditingController? passwordController = TextEditingController();

    final RegExp _emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    final RegExp _passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

    bool showError_Email = false;
    bool showError_Password = false;

    late String Error_text_Email;
    late String Error_text_Password;

    bool loading = false;
    bool error = false;

    String Error_msg = "";

    void initState() {
      super.initState();
      emailController.addListener(() {
        final String text = emailController.text.toLowerCase();
        emailController.value = emailController.value.copyWith(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      });

      passwordController.addListener(() {
        final String text = passwordController.text.toLowerCase();
        passwordController.value = passwordController.value.copyWith(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      });
    }

    Future<User?> signInUsingEmailPassword({
      required String Email,
      required String Password,
      required BuildContext Context,
    }) async {
      FirebaseAuth auth = FirebaseAuth.instance;

      User? user;

      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: Email,
          password: Password,
        );
        user = userCredential.user;
        // ignore: use_build_context_synchronously
        if (user != null) {
          print("Login Successful");
          // ignore: use_build_context_synchronously
          Navigator.popAndPushNamed(context, "/HomePage");
        }
        // Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        loading = false;
        error = true;
        if (e.code == 'user-not-found') {
          Error_msg = "No user found for that email.";
          print('No user found for that email.');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message.toString()),
            ),
          );

          return null;
        } else if (e.code == 'wrong-password') {
          Error_msg = "Wrong password provided.";
          print('Wrong password provided.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message.toString()),
            ),
          );
          loading = false;
          return null;
        } else {
          Error_msg = "Something went wrong";
          print("Something went wrong");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message.toString()),
            ),
          );
          loading = false;
          return null;
        }
      }

      // return user;
    }

    Future<User?> SignInWithGoogle() async {
      // await Firebase.initializeApp();
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.signOut();
      User? user;
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        // print("signed in " + user!.displayName!);
        if (user != null) {
          Navigator.popAndPushNamed(context, "/HomePage");
        } else {
          error = true;
        }
      } catch (e) {
        print(e);
      }
      return user;
    }

    HandleValidate_Email() {
      if (emailController.text.isEmpty) {
        showError_Email = true;
        Error_text_Email = 'Please Enter Email';
      } else if (!_emailRegex.hasMatch(emailController.text)) {
        showError_Email = true;
        Error_text_Email = 'Please Enter Valid Email';
      } else {
        showError_Email = false;
      }
    }

    HandleValidate_Password() {
      if (passwordController.text.isEmpty) {
        showError_Password = true;
        Error_text_Password = 'Please Enter Password';
      } else if (!_passwordRegex.hasMatch(passwordController.text)) {
        showError_Password = true;
        Error_text_Password =
            'Password must contain at least 8 characters, including uppercase,\nlowercase letters and numbers';
      } else {
        showError_Password = false;
      }
    }

    void login() async {
      String email = emailController.text;
      String password = passwordController.text;

      HandleValidate_Email();
      HandleValidate_Password();

      if (formkey.currentState!.validate()) {
        print('Validated');
        User? user = await signInUsingEmailPassword(
            Email: email, Password: password, Context: context);

        if (user == null && error == false) {
          setState(() {
            loading = true;
          });
          // ignore: use_build_context_synchronously
        } else if (user == null && error == true) {
          setState(() {
            loading = false;
          });
        } else {
          setState(() {
            loading = false;
          });
          // Navigator.pushNamed(context, "/test");
        }
      } else {
        print('Not Validated');
      }
    }

    if (error == true) {
      return AlertDialog(
        title: const Text("Error"),
        content: Text("error Aya hai"),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.pop(context);

              error = false;
            },
            child: const Text("OK"),
          )
        ],
      );
    }
    return SafeArea(
      child: ListView(
        children: [
          // Image.asset('assets/tablet.png'),
          Image.asset(
              key: const ValueKey("Login_Center"), 'assets/images/login.png'),
          SingleChildScrollView(
              child: Form(
            key: formkey,
            child: Column(children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (showError_Email) {
                      return Error_text_Email;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (showError_Password) {
                      return Error_text_Password;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                    key: ValueKey('Login'),
                    onTap: () {
                      login();
                    },
                    child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 88, 223, 250),
                                Color.fromARGB(85, 73, 195, 236)
                              ]),
                        ),
                        child: const Center(
                            child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )))),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.black)),
                    Text('    OR Login In With    '),
                    Expanded(
                        child: Divider(
                      color: Colors.black,
                    ))
                  ],
                ),
              ),
              SizedBox(
                width: 75,
                height: 75,
                child: IconButton(
                    onPressed: () {
                      SignInWithGoogle();
                    },
                    icon: Image.asset(
                      'assets/images/icons8-google-500.png',
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text('Don\'t have an account?'),
                  TextButton(
                    key: const ValueKey("SignUp"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignUp');
                    },
                    child: const Text('Sign Up'),
                  )
                ],
              ),
            ]),
          ))
        ],
      ),
    );
  }
}
