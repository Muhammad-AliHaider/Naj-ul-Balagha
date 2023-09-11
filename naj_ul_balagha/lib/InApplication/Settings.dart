import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naj_ul_balagha/InApplication/Settings_constants.dart';

class Settings extends StatefulWidget {
  final Settings_Constants FontSizes;

  const Settings({Key? key, required this.FontSizes}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var _ArabicFontSize = widget.FontSizes.ArabicFontSize;
    var _UrduFontSize = widget.FontSizes.UrduFontSize;

    return Scaffold(
        appBar: AppBar(
          title: Text("سیٹنگز"),
          surfaceTintColor: Color.fromARGB(84, 73, 236, 201),
          shadowColor: Colors.grey.withOpacity(0.5),
          backgroundColor: Color.fromARGB(255, 65, 205, 149),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(Icons.arrow_forward),
          //   )
          // ],
        ),
        body: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Text("حرف کا سائز"),
                  Slider(
                    value: _ArabicFontSize,
                    min: 10,
                    max: 50,
                    divisions: 5,
                    onChanged: (double value) {
                      setState(() {
                        _ArabicFontSize = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Card(
              child: Slider(
                value: 0.5,
                onChanged: (double value) {},
              ),
            )
          ],
        ));
  }
}
