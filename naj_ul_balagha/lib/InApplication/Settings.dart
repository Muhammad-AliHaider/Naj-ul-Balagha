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
                Text("عربی حرف کا سائز", style: TextStyle(fontSize: 25)),
                Slider(
                  value: _ArabicFontSize,
                  min: 10,
                  max: 50,
                  label: _ArabicFontSize.round().toString(),
                  thumbColor: Color.fromARGB(255, 65, 205, 149),
                  activeColor: Color.fromARGB(255, 65, 205, 149),
                  inactiveColor: Color.fromARGB(255, 32, 99, 72),
                  onChanged: (double value) {
                    setState(() {
                      _ArabicFontSize = value;
                      widget.FontSizes.setArabicFontSize(value);
                    });
                  },
                ),
                Text("نمونہ متن",
                    style: TextStyle(
                      fontFamily: 'Mohammadi',
                      fontSize: _ArabicFontSize,
                    )),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Text("اردو حرف کا سائز", style: TextStyle(fontSize: 25)),
                Slider(
                  value: _UrduFontSize,
                  min: 10,
                  max: 50,
                  label: _UrduFontSize.round().toString(),
                  thumbColor: Color.fromARGB(255, 65, 205, 149),
                  activeColor: Color.fromARGB(255, 65, 205, 149),
                  inactiveColor: Color.fromARGB(255, 32, 99, 72),
                  onChanged: (double value) {
                    setState(() {
                      _UrduFontSize = value;
                      widget.FontSizes.setUrduFontSize(value);
                    });
                  },
                ),
                Text(
                  "نمونہ متن",
                  style: TextStyle(
                    fontFamily: 'Alvi',
                    fontSize: _UrduFontSize,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 150,
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 65, 205, 149),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/HomePage", (route) => false);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(30, 30))),
          child: Text(
            "محفوظ کریں",
            style: TextStyle(fontFamily: "Alvi", fontSize: 20),
          ),
        ),
      ),
    );
  }
}
