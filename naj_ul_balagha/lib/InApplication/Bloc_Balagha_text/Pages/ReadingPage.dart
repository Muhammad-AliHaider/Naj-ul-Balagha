import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

import '../../Settings_constants.dart';
import '../BalaghatextEvents.dart';
import '../BalaghatextStates.dart';
import '../BalaghatextBloc.dart';
import '../BalaghatextRepo/BalaghatextRepo.dart';

///sharing platform
enum Share {
  facebook,
  messenger,
  twitter,
  whatsapp,
  share_system,
  share_telegram,
}

Future<void> onButtonTap(Share share, String msge) async {
  String msg = msge;
  String url = 'https://pub.dev/packages/flutter_share_me';

  String? response;
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  switch (share) {
    case Share.share_system:
      response = await flutterShareMe.shareToSystem(msg: msg);
      break;
    case Share.facebook:
      response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
      break;
    case Share.messenger:
      response = await flutterShareMe.shareToMessenger(url: url, msg: msg);
      break;
    case Share.twitter:
      response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
      break;
    case Share.whatsapp:
      response = await flutterShareMe.shareToWhatsApp(msg: msg);
      break;

    case Share.share_telegram:
      response = await flutterShareMe.shareToTelegram(msg: msg);
      break;
  }
  debugPrint(response);
}

class ReadingPage extends StatefulWidget {
  final int Type;
  final int TypeNo;
  final String title;
  final int totalTypeNo;
  final BalaghaTextRepo? repo;
  final Settings_Constants FontSize;
  final FirebaseAuth? auth;
  const ReadingPage(
      {Key? key,
      required this.Type,
      required this.TypeNo,
      required this.title,
      required this.totalTypeNo,
      required this.FontSize,
      this.auth,
      this.repo})
      : super(key: key);
  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  @override
  Widget build(BuildContext context) {
    User? user = widget.auth == null
        ? FirebaseAuth.instance.currentUser
        : widget.auth!.currentUser;
    BalaghaTextRepo? repository =
        widget.repo == null ? BalaghaTextRepo() : widget.repo!;

    //ANCHOR - Function for spliting Hawashi
    SplitHawashi(String text) {
      List<String> Hawashi = text.split('\$');
      print("yeha say ");
      print(Hawashi);
      return Hawashi;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
          shadowColor: Colors.grey.withOpacity(0.5),
          backgroundColor: Color.fromARGB(255, 65, 205, 149),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_forward),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                // <-- SEE HERE
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 65, 205, 149)),
                accountName: Text(widget.auth == null
                    ? user!.displayName.toString()
                    : "user"),
                accountEmail: Text(
                  widget.auth == null ? user!.email.toString() : "user email",
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
                  // Navigator.popUntil(context, ModalRoute.withName('/HomePage'));
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/Profile', ModalRoute.withName('/HomePage'));
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
        body: BlocProvider(
            create: (context) => BalaghaTextBloc(BalaghaTextRepo())
              ..add(textReadEvent(Type: widget.Type, TypeNo: widget.TypeNo)),
            child: BlocBuilder<BalaghaTextBloc, textStateBloc>(
              builder: (context, state) {
                if (state is BlocLoad) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is BlocError) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Error'),
                    ),
                  );
                } else if (state is BlocSuccess) {
                  return Stack(
                    children: [
                      SizedBox(
                          child: Image.asset(
                        'assets/images/bg3.jpg',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )),
                      InteractiveViewer(
                        panEnabled:
                            false, // Set it to false to prevent panning.
                        // boundaryMargin: EdgeInsets.all(80),
                        minScale: 1,
                        maxScale: 4,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 50),
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: Card(
                                child: InkWell(
                                  onLongPress: () {
                                    // await Clipboard.setData(
                                    //     ClipboardData(text: "your text"));
                                    //     ScaffoldMessenger.of(context);
                                    // copied successfully
                                  },
                                  onTap: () {
                                    //ANCHOR - Change here for Hawashi logic use of spliting function
                                    state.data[index].Hawashi != null
                                        ? showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              // <-- SEE HERE
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(25.0),
                                              ),
                                            ),
                                            builder: (BuildContext context) {
                                              return Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(25.0),
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            255, 65, 205, 149),
                                                        Color.fromARGB(
                                                            84, 73, 236, 201)
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:

                                                            //ANCHOR - Change here for Haeashi

                                                            SplitHawashi(state
                                                                        .data[
                                                                            index]
                                                                        .Hawashi
                                                                        .toString())
                                                                    .isNotEmpty
                                                                ? ListView
                                                                    .builder(
                                                                    itemCount: SplitHawashi(state
                                                                            .data[index]
                                                                            .Hawashi
                                                                            .toString())
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            i) {
                                                                      return ListTile(
                                                                        title: SplitHawashi(state.data[index].Hawashi.toString())[i].startsWith('#')
                                                                            ? Text(SplitHawashi(state.data[index].Hawashi.toString())[i].substring(1),
                                                                                style: TextStyle(fontFamily: 'Mohammdi', fontSize: widget.FontSize.ArabicFontSize),
                                                                                textAlign: TextAlign.justify)
                                                                            : Text(SplitHawashi(state.data[index].Hawashi.toString())[i], style: TextStyle(fontFamily: 'Alvi', fontSize: widget.FontSize.UrduFontSize), textAlign: TextAlign.justify),
                                                                      );
                                                                    },
                                                                  )
                                                                : Container(),
                                                      ),
                                                    ),
                                                  ));
                                            })
                                        : null;
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                            state.data[index].AR.toString(),
                                            style: TextStyle(
                                                fontFamily: 'Mohammdi',
                                                fontSize: widget
                                                    .FontSize.ArabicFontSize),
                                            textAlign: TextAlign.justify),
                                        subtitle: Text(
                                            state.data[index].UR != null
                                                ? state.data[index].UR
                                                    .toString()
                                                : '',
                                            style: TextStyle(
                                                fontFamily: 'Alvi',
                                                fontSize: widget
                                                    .FontSize.UrduFontSize),
                                            textAlign: TextAlign.justify),
                                      ),
                                      Row(
                                        children: [
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      // Share.share("Hello");

                                                      showModalBottomSheet(
                                                          context: context,
                                                          // isScrollControlled: true,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            // <-- SEE HERE
                                                            borderRadius:
                                                                BorderRadius
                                                                    .vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      25.0),
                                                            ),
                                                          ),
                                                          builder: (BuildContext
                                                              context) {
                                                            String msg =
                                                                'عربی : ${state.data[index].AR.toString()}\n \n اردو : ${state.data[index].UR.toString()}';
                                                            return Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        8,
                                                                        8,
                                                                        0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Container(
                                                                          // IconButton(
                                                                          // onPressed: () {
                                                                          //   SignInWithGoogle();
                                                                          // },
                                                                          // icon: Image.asset(
                                                                          //   'assets/images/icons8-google-500.png',
                                                                          // )),
                                                                          child: IconButton(
                                                                              onPressed: () => onButtonTap(Share.twitter, msg),
                                                                              icon: Image.asset('assets/icons/twitter.svg')),
                                                                        ),
                                                                        // ListTile(
                                                                        //   onTap:
                                                                        //       () {
                                                                        //     onButtonTap(
                                                                        //         Share.twitter,
                                                                        //         msg);
                                                                        //     // Share.share(
                                                                        //     //     "Hello");
                                                                        //     // Share.share(state
                                                                        //     //     .data[index]
                                                                        //     //     .AR
                                                                        //     //     .toString());

                                                                        //     // copied successfully
                                                                        //   },
                                                                        //   leading:
                                                                        //       Icon(
                                                                        //     Icons
                                                                        //         .share,
                                                                        //     size:
                                                                        //         20,
                                                                        //   ),
                                                                        //   title:
                                                                        //       Text(
                                                                        //     "Twitter شيئر کریں۔",
                                                                        //     style: TextStyle(
                                                                        //         fontFamily:
                                                                        //             'Alvi',
                                                                        //         fontSize:
                                                                        //             widget.FontSize.UrduFontSize),
                                                                        //   ),
                                                                        // ),
                                                                        // Divider(),
                                                                        // ListTile(
                                                                        //   onTap:
                                                                        //       () {
                                                                        //     // Share.share(state
                                                                        //     //     .data[index]
                                                                        //     //     .UR
                                                                        //     //     .toString());

                                                                        //     // copied successfully
                                                                        //   },
                                                                        //   leading:
                                                                        //       Icon(
                                                                        //     Icons
                                                                        //         .share,
                                                                        //     size:
                                                                        //         20,
                                                                        //   ),
                                                                        //   title:
                                                                        //       Text(
                                                                        //     "اردو شيئر کریں۔",
                                                                        //     style: TextStyle(
                                                                        //         fontFamily:
                                                                        //             'Alvi',
                                                                        //         fontSize:
                                                                        //             widget.FontSize.UrduFontSize),
                                                                        //   ),
                                                                        // ),
                                                                        // Divider(),
                                                                        // ListTile(
                                                                        //   onTap:
                                                                        //       () async {
                                                                        //     // await Share.share(
                                                                        //     //     'عربی : ${state.data[index].AR.toString()}\n \n اردو : ${state.data[index].UR.toString()}');

                                                                        //     print(
                                                                        //         "share huraha");

                                                                        //     // Navigator.pop(
                                                                        //     //     context);
                                                                        //     // copied successfully
                                                                        //   },
                                                                        //   leading:
                                                                        //       Icon(
                                                                        //     Icons
                                                                        //         .share,
                                                                        //     size:
                                                                        //         20,
                                                                        //   ),
                                                                        //   title:
                                                                        //       Text(
                                                                        //     "دونوں شيئر کریں۔",
                                                                        //     style: TextStyle(
                                                                        //         fontFamily:
                                                                        //             'Alvi',
                                                                        //         fontSize:
                                                                        //             widget.FontSize.UrduFontSize),
                                                                        //   ),
                                                                        // ),
                                                                        // Divider()
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    icon: Icon(
                                                      Icons.share,
                                                    ),
                                                  ))),
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          // isScrollControlled: true,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            // <-- SEE HERE
                                                            borderRadius:
                                                                BorderRadius
                                                                    .vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      25.0),
                                                            ),
                                                          ),
                                                          builder: (BuildContext
                                                              context) {
                                                            return Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        8,
                                                                        8,
                                                                        0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    ListTile(
                                                                      onTap:
                                                                          () async {
                                                                        await Clipboard.setData(ClipboardData(
                                                                            text:
                                                                                state.data[index].AR.toString()));
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content:
                                                                                Text("عربی کاپی ہوگیا۔", style: TextStyle(fontFamily: 'Alvi', fontSize: widget.FontSize.UrduFontSize))));
                                                                        Navigator.pop(
                                                                            context);
                                                                        // copied successfully
                                                                      },
                                                                      leading:
                                                                          Icon(
                                                                        Icons
                                                                            .copy,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        "عربی کاپی کریں۔",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Alvi',
                                                                            fontSize:
                                                                                widget.FontSize.UrduFontSize),
                                                                      ),
                                                                    ),
                                                                    Divider(),
                                                                    ListTile(
                                                                      onTap:
                                                                          () async {
                                                                        await Clipboard.setData(ClipboardData(
                                                                            text:
                                                                                state.data[index].UR.toString()));
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content:
                                                                                Text("اردو کاپی ہوگیا۔", style: TextStyle(fontFamily: 'Alvi', fontSize: widget.FontSize.UrduFontSize))));
                                                                        Navigator.pop(
                                                                            context);
                                                                        // copied successfully
                                                                      },
                                                                      leading:
                                                                          Icon(
                                                                        Icons
                                                                            .copy,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        "اردو کاپی کریں۔",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Alvi',
                                                                            fontSize:
                                                                                widget.FontSize.UrduFontSize),
                                                                      ),
                                                                    ),
                                                                    Divider(),
                                                                    ListTile(
                                                                      onTap:
                                                                          () async {
                                                                        await Clipboard.setData(ClipboardData(
                                                                            text:
                                                                                'عربی : ${state.data[index].AR.toString()}\n \n اردو : ${state.data[index].UR.toString()}'));
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content:
                                                                                Text("دونوں کاپی ہوگیا۔", style: TextStyle(fontFamily: 'Alvi', fontSize: widget.FontSize.UrduFontSize))));
                                                                        Navigator.pop(
                                                                            context);
                                                                        // copied successfully
                                                                      },
                                                                      leading:
                                                                          Icon(
                                                                        Icons
                                                                            .copy,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        "دونوں کاپی کریں۔",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Alvi',
                                                                            fontSize:
                                                                                widget.FontSize.UrduFontSize),
                                                                      ),
                                                                    ),
                                                                    Divider()
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    icon: Icon(
                                                      Icons.copy,
                                                    ),
                                                  ))),
                                          Spacer(),
                                          state.data[index].Hawashi != null
                                              ? Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        state.data[index]
                                                                    .Hawashi !=
                                                                null
                                                            ? showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  // <-- SEE HERE
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .vertical(
                                                                    top: Radius
                                                                        .circular(
                                                                            25.0),
                                                                  ),
                                                                ),
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              25.0),
                                                                        ),
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors: [
                                                                            Color.fromARGB(
                                                                                255,
                                                                                65,
                                                                                205,
                                                                                149),
                                                                            Color.fromARGB(
                                                                                84,
                                                                                73,
                                                                                236,
                                                                                201)
                                                                          ],
                                                                          begin:
                                                                              Alignment.topCenter,
                                                                          end: Alignment
                                                                              .bottomCenter,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(12.0),
                                                                        child:
                                                                            Card(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:

                                                                                //ANCHOR - Change here for Haeashi

                                                                                SplitHawashi(state.data[index].Hawashi.toString()).isNotEmpty
                                                                                    ? ListView.builder(
                                                                                        itemCount: SplitHawashi(state.data[index].Hawashi.toString()).length,
                                                                                        itemBuilder: (context, i) {
                                                                                          return ListTile(
                                                                                            title: SplitHawashi(state.data[index].Hawashi.toString())[i].startsWith('#') ? Text(SplitHawashi(state.data[index].Hawashi.toString())[i].substring(1), style: TextStyle(fontFamily: 'Mohammdi', fontSize: widget.FontSize.ArabicFontSize), textAlign: TextAlign.justify) : Text(SplitHawashi(state.data[index].Hawashi.toString())[i], style: TextStyle(fontFamily: 'Alvi', fontSize: widget.FontSize.UrduFontSize), textAlign: TextAlign.justify),
                                                                                          );
                                                                                        },
                                                                                      )
                                                                                    : Container(),
                                                                          ),
                                                                        ),
                                                                      ));
                                                                })
                                                            : null;
                                                      },
                                                      icon: Tooltip(
                                                        message: 'حواشی',
                                                        child: Icon(
                                                          Icons
                                                              .open_in_browser_outlined,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 65, 205, 149),
                                  Color.fromARGB(84, 73, 236, 201)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                          )),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                              iconSize: 50,
                              onPressed: () {
                                if (widget.TypeNo < widget.totalTypeNo) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReadingPage(
                                        Type: widget.Type,
                                        TypeNo: widget.TypeNo + 1,
                                        title: widget.title,
                                        totalTypeNo: widget.totalTypeNo,
                                        FontSize: widget.FontSize,
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(Icons.arrow_right))),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                              iconSize: 50,
                              onPressed: () {
                                if (widget.TypeNo > 1) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReadingPage(
                                        Type: widget.Type,
                                        TypeNo: widget.TypeNo - 1,
                                        title: widget.title,
                                        totalTypeNo: widget.totalTypeNo,
                                        FontSize: widget.FontSize,
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(Icons.arrow_left))),
                    ],
                  );
                } else {
                  return const Scaffold(
                    body: Center(
                      child: Text('SomeThing Went Wrong'),
                    ),
                  );
                }
              },
            )));
  }
}
