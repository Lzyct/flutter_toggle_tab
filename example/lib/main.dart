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
  var _tabTextIndexSelected = 1;
  var _tabTextIconIndexSelected = 0;
  var _tabIconIndexSelected = 0;
  var _tabSelectedIndexSelected = 0;

  var _listTextTabToggle = ["Tab A (10)", "Tab B (6)", "Tab C (9)"];
  var _listTextSelectedToggle = [
    "Select A (10)",
    "Select B (6)",
    "Select C (9)"
  ];
  var _listIconTabToggle = [
    Icons.person,
    Icons.pregnant_woman,
  ];
  var _listGenderText = ["Male", "Female"];
  var _listGenderEmpty = ["", ""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Tab Toggle"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// Basic Toggle Sample
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Text(
              "Basic Tab Toggle",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            FlutterToggleTab(
              // width in percent
              width: 90,
              borderRadius: 30,
              height: 50,
              selectedIndex: _tabTextIndexSelected,
              selectedBackgroundColors: [Colors.blue, Colors.blueAccent],
              selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              unSelectedTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              labels: _listTextTabToggle,
              selectedLabelIndex: (index) {
                setState(() {
                  _tabTextIndexSelected = index;
                });
              },
              isScroll: false,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tabTextIndexSelected = 2;
                });
              },
              child: Text("Change to Index 2"),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Text(
              "Index selected : $_tabTextIndexSelected",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Divider(
              thickness: 2,
            ),

            /// Text with icon sample
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Text(
              "Text With Icon",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
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
                    width: 50,
                    borderRadius: 15,
                    selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    unSelectedTextStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    labels: _listGenderText,
                    icons: _listIconTabToggle,
                    selectedIndex: _tabTextIconIndexSelected,
                    selectedLabelIndex: (index) {
                      setState(() {
                        _tabTextIconIndexSelected = index;
                      });
                    },
                  ),
                ],
              ),
            ),

            /// Icon with Text Button Sample
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Text(
              "Selected sex : ${_listGenderText[_tabTextIconIndexSelected]} ",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),

            /// Icon button sample
            Text(
              "With Icon Only and Implement margin for selected item",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
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
                    width: 40,
                    borderRadius: 15,
                    selectedIndex: _tabIconIndexSelected,
                    selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    unSelectedTextStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    labels: _listGenderEmpty,
                    icons: _listIconTabToggle,
                    iconSize: 40,
                    selectedLabelIndex: (index) {
                      setState(() {
                        _tabIconIndexSelected = index;
                      });
                    },
                    marginSelected:
                        EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Text(
              "Selected sex index: $_tabIconIndexSelected ",
              style: TextStyle(fontSize: 20),
            ),
            Divider(
              thickness: 2,
            ),

            /// Update select programmatically sample
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Text(
              "Update selected programmatically  ",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select your sex : ",
                    style: TextStyle(fontSize: 20),
                  ),
                  FlutterToggleTab(
                    width: 90,
                    borderRadius: 15,
                    selectedIndex: _tabSelectedIndexSelected,
                    selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    unSelectedTextStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    labels: _listTextSelectedToggle,
                    selectedLabelIndex: (index) {
                      setState(() {
                        _tabSelectedIndexSelected = index;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _tabSelectedIndexSelected = 2;
                      });
                    },
                    child: Text("Select C"),
                  )
                ],
              ),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Text(
              "Selected sex index: $_tabIconIndexSelected ",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
