import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'bloc/UserBloc.dart';
import 'bloc/UserEvents.dart';
import 'bloc/UserRepo.dart';
import 'bloc/UserStates.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    // TextEditingController dateInput = TextEditingController();

    TextEditingController dateInput = TextEditingController();
    TextEditingController? emailController = TextEditingController();
    TextEditingController? passwordController = TextEditingController();
    TextEditingController? confirmPasswordController = TextEditingController();
    TextEditingController? userNameController = TextEditingController();

    @override
    void initState() {
      dateInput.text = ""; //set the initial value of text field
      super.initState();
    }

    final RegExp _emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    final RegExp _passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

    bool showError_Email = false;
    bool showError_Password = false;
    bool showError_ConfirmPassword = false;
    bool showError_UserName = false;
    bool showError_BirthDate = false;

    late String Error_text_Email;
    late String Error_text_Password;
    late String Error_text_ConfirmPassword;
    late String Error_text_UserName;
    late String Error_text_BirthDate;

    bool loading = false;
    bool error = false;

    GlobalKey<FormState> formkey = GlobalKey<FormState>();

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

    HandleValidate_ConfirmPassword() {
      if (confirmPasswordController.text.isEmpty) {
        showError_ConfirmPassword = true;
        Error_text_ConfirmPassword = 'Please Enter Confirm Password';
      } else if (confirmPasswordController.text != passwordController.text) {
        showError_ConfirmPassword = true;
        Error_text_ConfirmPassword = 'Password Not Match';
      } else {
        showError_ConfirmPassword = false;
      }
    }

    HandleValidate_UserName() {
      if (userNameController.text.isEmpty) {
        showError_UserName = true;
        Error_text_UserName = 'Please Enter UserName';
      } else {
        showError_UserName = false;
      }
    }

    HandleValidate_BirthDate() {
      if (dateInput.text.isEmpty) {
        showError_BirthDate = true;
        Error_text_BirthDate = 'Please Enter BirthDate';
      } else {
        showError_BirthDate = false;
      }
    }

    Future<User?> SignUpUsingEmailAndPass({
      required String email,
      required String password,
      required BuildContext context,
    }) async {
      await Firebase.initializeApp();
      FirebaseAuth _auth = FirebaseAuth.instance;

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(userCredential.user!.uid);
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
          ),
        );
        return null;
      }
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
          // Navigator.popAndPushNamed(context, "/test");
          return user;
        }
        // Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
          error = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
          ),
        );
      }
    }

    void SignUp(context) async {
      String email = emailController.text;
      String password = passwordController.text;
      String UserName = userNameController.text;
      String BirthDate = dateInput.text;

      HandleValidate_Email();
      HandleValidate_Password();
      HandleValidate_ConfirmPassword();
      HandleValidate_UserName();
      HandleValidate_BirthDate();

      if (formkey.currentState!.validate()) {
        print('Validated');
        setState(() {
          loading = true;
        });

        await SignUpUsingEmailAndPass(
          email: email,
          password: password,
          context: context,
        );

        User? user = await signInUsingEmailPassword(
            Email: email, Password: password, Context: context);

        if (user != null) {
          print(user.uid);

          BlocProvider.of<UserBloc>(context).add(userAdd_Event(
              Email: email,
              Password: password,
              UserName: UserName,
              BirthDate: BirthDate,
              uid: user.uid));
        } else {
          setState(() {
            loading = false;
            error = true;
          });

          setState(() {
            loading = false;
          });
        }
        // FirebaseAuth.instance.signOut();
      } else {
        print('Not Validated');
      }
    }

    return BlocProvider(
      create: (create) => UserBloc(
        UserRepo(),
      ),
      child: BlocListener<UserBloc, StateBlock>(
        listener: (context, state) {
          if (state is BlocSuccess) {
            setState(() {
              loading = false;
            });
            Navigator.popAndPushNamed(context, '/');
          }
        },
        child: BlocBuilder<UserBloc, StateBlock>(
          builder: (context, state) {
            if (state is BlocLoad) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BlocInitial) {
              return Scaffold(
                body: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            SizedBox(
                                child: Image.asset(
                                    "assets/images/BG_SignUP_2.png")),
                            Card(
                                child: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 139, 241, 200)),
                                      ),
                                      suffixIcon: const Icon(Icons.email),
                                      suffixIconColor: const Color.fromARGB(
                                          255, 139, 241, 200),
                                    ),
                                    validator: (value) {
                                      if (showError_Email) {
                                        return Error_text_Email;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 139, 241, 200)),
                                      ),
                                      suffixIcon: const Icon(Icons.password),
                                      suffixIconColor: const Color.fromARGB(
                                          255, 139, 241, 200),
                                    ),
                                    validator: (value) {
                                      if (showError_Password) {
                                        return Error_text_Password;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: confirmPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 139, 241, 200)),
                                      ),
                                      suffixIcon:
                                          const Icon(Icons.password_outlined),
                                      suffixIconColor: const Color.fromARGB(
                                          255, 139, 241, 200),
                                    ),
                                    validator: (value) {
                                      if (showError_ConfirmPassword) {
                                        return Error_text_ConfirmPassword;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: userNameController,
                                    decoration: InputDecoration(
                                      labelText: 'UserName',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 139, 241, 200)),
                                      ),
                                      suffixIcon: const Icon(Icons.person),
                                      suffixIconColor: const Color.fromARGB(
                                          255, 139, 241, 200),
                                    ),
                                    validator: (value) {
                                      if (showError_UserName) {
                                        return Error_text_UserName;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    readOnly: true,
                                    controller: dateInput,
                                    decoration: InputDecoration(
                                      labelText: 'BirthDate',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 139, 241, 200)),
                                      ),
                                      suffixIcon: const Icon(Icons.date_range),
                                      suffixIconColor: const Color.fromARGB(
                                          255, 139, 241, 200),
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        dateInput.text =
                                            formattedDate; //set output date to TextField value.
                                      } else {}
                                    },
                                    validator: (value) {
                                      if (showError_BirthDate) {
                                        return Error_text_BirthDate;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          SignUp(context);
                                        },
                                        child: Container(
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 112, 255, 219),
                                                    Color.fromARGB(
                                                        84, 73, 236, 192)
                                                  ]),
                                            ),
                                            child: const Center(
                                                child: Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )))),
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is BlocError || error) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
