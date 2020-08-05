import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter_toggle_tab/helper.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Toggle Tab Sample Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _tabIndexSelected = 0;
  var _toggleIndexSelected = 0;

  @override
  Widget build(BuildContext context) {
    var _listTitleTab = ["Tab A (10)", "Tab B (6)", "Tab C (9)"];
    var _listGenderIcon = [
      Icon(
        Icons.person,
        color: Colors.white,
      ),
      Icon(
        Icons.pregnant_woman,
        color: Colors.white,
      ),
    ];
    var _listGender = ["", ""];

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: heightInPercent(10, context),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ini Header',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: heightInPercent(10, context),
                ),
                FlutterToggleTab(
                  // width in percent
                  width: 90,
                  height: 50,
                  initialLabelIndex: 0,
                  selectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  unSelectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  labels: _listTitleTab,
                  selectedDecoration: BoxDecoration(color: Colors.blue),
                  unSelectedDecoration: BoxDecoration(color: Colors.grey),
                  selectedLabelIndex: (index) {
                    setState(() {
                      _tabIndexSelected = index;
                    });
                  },
                ),
                SizedBox(
                  height: heightInPercent(5, context),
                ),
                Text(
                  "Index selected : $_tabIndexSelected",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: heightInPercent(5, context),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: heightInPercent(5, context),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select your sex : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      FlutterToggleTab(
                        // width in percent
                        width: 50,
                        initialLabelIndex: 0,
                        selectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        unSelectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        labels: _listGender,
                        icons: _listGenderIcon,
                        selectedDecoration: BoxDecoration(color: Colors.blue),
                        unSelectedDecoration: BoxDecoration(color: Colors.grey),
                        selectedLabelIndex: (index) {
                          setState(() {
                            _toggleIndexSelected = index;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: heightInPercent(5, context),
                ),
                Text(
                  "Selected sex : ${_listGender[_toggleIndexSelected]} - $_toggleIndexSelected",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
