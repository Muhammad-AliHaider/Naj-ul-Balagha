import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naj_ul_balagha/InApplication/Bookmarks/BookmarksBloc.dart';
import 'package:naj_ul_balagha/InApplication/Bookmarks/BookmarksStates.dart';
import 'package:naj_ul_balagha/InApplication/Bookmarks/Repo/BookmarksRepo.dart';
import 'package:naj_ul_balagha/InApplication/Muqadmat/Pages/RPHurf-e-Agas.dart';
import 'package:naj_ul_balagha/InApplication/Settings_constants.dart';

import '../../Bloc_Balagha_text/Pages/ReadingPage.dart';
import '../BookmarksEvents.dart';

class BookmarksView extends StatefulWidget {
  final FirebaseAuth? auth;
  final BookmarksRepo? repo;
  final Function(Locale) changeLocale;
  final Settings_Constants FontSizes;
  const BookmarksView(
      {Key? key,
      required this.changeLocale,
      required this.FontSizes,
      this.auth,
      this.repo})
      : super(key: key);

  @override
  _BookmarksViewState createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
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
    User? user = widget.auth == null
        ? FirebaseAuth.instance.currentUser
        : widget.auth!.currentUser;

    BookmarksRepo repository =
        widget.repo == null ? BookmarksRepo() : widget.repo!;

    return Scaffold(
      appBar: AppBar(
        title: Text("بک مارکس"),
        surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
        shadowColor: Colors.grey.withOpacity(0.5),
        backgroundColor: Color.fromARGB(255, 65, 205, 149),
      ),
      body: BlocProvider(
          create: (create) => BookmarksBloc(repository: repository)
            ..add(BookMarksReadAllEvent(
                uid: widget.auth == null ? user!.uid : "1")),
          child: BlocListener<BookmarksBloc, BookmarkStates>(
              listener: (context, state) {
            if (state is BookmarkBlocMove) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/BookmarksView', ModalRoute.withName('/HomePage'));
            }
          }, child: BlocBuilder<BookmarksBloc, BookmarkStates>(
                  builder: (context, state) {
            if (state is BookmarkBlocSuccess) {
              return Stack(
                children: [
                  Image.asset(
                    'assets/images/bg3.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  if (state.data.isNotEmpty)
                    ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                String title = '';
                                switch (state.data[index].typeid) {
                                  case 1:
                                    title = 'خطبات';
                                    break;
                                  case 2:
                                    title = 'مکتوبات';
                                    break;
                                  case 3:
                                    title = 'حکم و مواعظ';
                                    break;
                                  case 4:
                                    title = 'تشریح طلب کلام';
                                    break;
                                  case 5:
                                    title = 'حرف آغاز';
                                }
                                if (state.data[index].typeid != 5) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReadingPage(
                                        Type: state.data[index].typeid as int,
                                        title: title,
                                        TypeNo: state.data[index].typeNo as int,
                                        totalTypeNo: state
                                            .data[index].totaltypeNo as int,
                                        FontSize: widget.FontSizes,
                                      ),
                                    ),
                                  );
                                }
                                if (state.data[index].typeid == 5) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RPHurf(
                                        Type: state.data[index].typeNo as int,
                                        totalTypeNo: state
                                            .data[index].totaltypeNo as int,
                                        FontSizes: widget.FontSizes,
                                      ),
                                    ),
                                  );
                                }
                              },
                              title: Text(state.data[index].Description!),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<BookmarksBloc>(context).add(
                                      DeleteBookmarksEvent(
                                          id: state.data[index].id));
                                },
                              ),
                            ),
                          );
                        }),
                  if (state.data.isEmpty)
                    const Center(child: Text("No Bookmarks")),
                ],
              );
            }
            if (state is BookmarkBlocError) {
              return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<BookmarksBloc>(context).add(
                        BookMarksReadAllEvent(
                            uid: widget.auth == null ? user!.uid : "1"));
                  },
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/bg3.jpg',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const Center(child: Text("Error")),
                    ],
                  ));
            }
            if (state is BookmarkBlocLoad) {
              return Stack(
                children: [
                  Image.asset(
                    'assets/images/bg3.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  const Center(child: CircularProgressIndicator()),
                ],
              );
            } else {
              return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<BookmarksBloc>(context).add(
                        BookMarksReadAllEvent(
                            uid: widget.auth == null ? user!.uid : "1"));
                  },
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/bg3.jpg',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  ));
            }
          }))),
    );
  }
}
