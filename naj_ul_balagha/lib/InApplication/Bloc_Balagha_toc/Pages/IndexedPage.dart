import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naj_ul_balagha/InApplication/Bookmarks/BookmarksBloc.dart';
import 'package:naj_ul_balagha/InApplication/Bookmarks/BookmarksStates.dart';
import 'package:naj_ul_balagha/InApplication/Settings_constants.dart';

import '../Repo/balaghatocRepo.dart';
import '../balaghatocbloc.dart';
import '../balaghatocEvents.dart';
import '../balaghatocStates.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Bookmarks/BookmarksEvents.dart';
import '../../Bookmarks/Repo/BookmarksRepo.dart';
import '../../Muqadmat/Pages/RPHurf-e-Agas.dart';
import '../../Bloc_Balagha_text/Pages/ReadingPage.dart';

class BalaghaToc extends StatefulWidget {
  final int TypeId;
  final String title;
  final BalaghatocRepo? repo;
  final FirebaseAuth? auth;
  final Settings_Constants FontSize;
  final Function(Locale) changeLocale;

  const BalaghaToc(
      {Key? key,
      required this.TypeId,
      required this.title,
      required this.changeLocale,
      required this.FontSize,
      this.repo,
      this.auth})
      : super(key: key);

  @override
  _BalaghaTocState createState() => _BalaghaTocState();
}

class _BalaghaTocState extends State<BalaghaToc> {
  Future<void> _initLocale() async {
    await Future.delayed(Duration.zero); // Delay execution until after build
    widget.changeLocale(const Locale('fa', 'IR')); // Change to French locale
    setState(() {}); // Rebuild the widget
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    int TypeId = widget.TypeId;
    int TypeNo = 0;
    String Description = '';
    int totalTypeNo = 0;
    BalaghatocRepo balaghatocRepo =
        widget.repo == null ? BalaghatocRepo() : widget.repo!;

    var user = widget.auth == null
        ? FirebaseAuth.instance.currentUser
        : widget.auth!.currentUser;

    return BlocProvider(
      create: (context) => balaghaBloc(repository: balaghatocRepo)
        ..add(tocReadEvent(TypeId: widget.TypeId)),
      child: BlocBuilder<balaghaBloc, tocStateBloc>(
        builder: (context, state) {
          if (state is BlocLoad) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is BlocSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
                shadowColor: Colors.grey.withOpacity(0.5),
                backgroundColor: Color.fromARGB(255, 65, 205, 149),
              ),
              drawer: Drawer(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      // <-- SEE HERE
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 65, 205, 149)),
                      accountName: Text(widget.auth == null
                          ? user!.displayName.toString()
                          : "user"),
                      accountEmail: Text(
                        widget.auth == null
                            ? user!.email.toString()
                            : "user email",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: widget.auth != null
                            ? Text(
                                "P",
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : user!.photoURL != null
                                ? Image.network(user.photoURL.toString())
                                : Text(
                                    "P",
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                      ),
                      title: const Text('Home'),
                      onTap: () {
                        // Navigator.popUntil(
                        //     context, ModalRoute.withName('/HomePage'));
                        // Navigator.popAndPushNamed(context, '/HomePage');
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/HomePage', (route) => false);
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                      ),
                      title: const Text('Profile'),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/Profile',
                            ModalRoute.withName('/HomePage'));
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.auto_stories_rounded,
                      ),
                      title: const Text('پیش گفتار'),
                      onTap: () {
                        Navigator.pushNamed(context, '/PaishGhuftar');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                      ),
                      title: const Text('سیٹنگز'),
                      onTap: () {
                        Navigator.pushNamed(context, '/Settings');
                      },
                    ),
                    Divider(),
                  ],
                ),
              ),
              body: Stack(
                children: [
                  Image.asset(
                    'assets/images/bg3.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(state.data[index].Description as String,
                              style: TextStyle(
                                fontFamily: 'Alvi',
                                fontSize: widget.FontSize.UrduFontSize,
                              )),
                          onTap: () {
                            if (widget.TypeId != 5) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReadingPage(
                                    Type: widget.TypeId,
                                    title: widget.title,
                                    TypeNo: state.data[index].typeNo as int,
                                    totalTypeNo: state.data.length,
                                    FontSize: widget.FontSize,
                                  ),
                                ),
                              );
                            }
                            if (widget.TypeId == 5) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RPHurf(
                                    Type: (state.data[index].typeNo as int) + 2,
                                    totalTypeNo: 6,
                                    FontSizes: widget.FontSize,
                                  ),
                                ),
                              );
                            }
                          },
                          onLongPress: () {
                            if (widget.TypeId != 5) {
                              TypeNo = state.data[index].typeNo as int;
                              Description =
                                  state.data[index].Description as String;
                              totalTypeNo = state.data.length;
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    // <-- SEE HERE
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (BuildContext innercontext) {
                                    return BlocProvider(
                                        create: (create) => BookmarksBloc(
                                            repository: BookmarksRepo()),
                                        child: BlocListener<BookmarksBloc,
                                            BookmarkStates>(
                                          listener: (innercontext, state) {
                                            if (state is BookmarkBlocMove) {
                                              ScaffoldMessenger.of(innercontext)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Added to the bookmark'),
                                                duration: Duration(seconds: 1),
                                              ));
                                              Navigator.pop(innercontext);
                                            }
                                          },
                                          child: BlocBuilder<BookmarksBloc,
                                                  BookmarkStates>(
                                              builder: (innercontext, state) {
                                            if (state is BookmarkBlocLoad) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (state
                                                is BookmarkBlocInitial) {
                                              return ListTile(
                                                title: Text('Add to Bookmark'),
                                                onTap: () {
                                                  BlocProvider.of<
                                                              BookmarksBloc>(
                                                          innercontext)
                                                      .add(AddBookmarksEvent(
                                                          typeid: widget.TypeId,
                                                          typeNo: TypeNo,
                                                          Description:
                                                              Description,
                                                          uid: user!.uid,
                                                          totaltypeNo:
                                                              totalTypeNo));
                                                },
                                                leading: Icon(Icons.bookmark),
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          }),
                                        ));
                                  });
                            }

                            if (widget.TypeId == 5) {
                              TypeNo = (state.data[index].typeNo as int) + 2;
                              Description =
                                  state.data[index].Description as String;
                              totalTypeNo = 6;
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    // <-- SEE HERE
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (BuildContext innercontext) {
                                    return BlocProvider(
                                        create: (create) => BookmarksBloc(
                                            repository: BookmarksRepo()),
                                        child: BlocListener<BookmarksBloc,
                                            BookmarkStates>(
                                          listener: (innercontext, state) {
                                            if (state is BookmarkBlocMove) {
                                              ScaffoldMessenger.of(innercontext)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Added to the bookmark'),
                                                duration: Duration(seconds: 1),
                                              ));
                                              Navigator.pop(innercontext);
                                            }
                                          },
                                          child: BlocBuilder<BookmarksBloc,
                                                  BookmarkStates>(
                                              builder: (innercontext, state) {
                                            if (state is BookmarkBlocLoad) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (state
                                                is BookmarkBlocInitial) {
                                              return ListTile(
                                                title: Text('Add to Bookmark'),
                                                onTap: () {
                                                  BlocProvider.of<
                                                              BookmarksBloc>(
                                                          innercontext)
                                                      .add(AddBookmarksEvent(
                                                          typeid: widget.TypeId,
                                                          typeNo: TypeNo,
                                                          Description:
                                                              Description,
                                                          uid: user!.uid,
                                                          totaltypeNo:
                                                              totalTypeNo));
                                                },
                                                leading: Icon(Icons.bookmark),
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          }),
                                        ));
                                  });
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is BlocError) {
            return Scaffold(
              body: Center(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}
