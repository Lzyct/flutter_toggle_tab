import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter_toggle_tab/helper.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
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
      home: const MyHomePage(title: 'Toggle Tab Sample Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(1);
  final ValueNotifier<int> _tabIndexTextWithIcon = ValueNotifier(0);
  final ValueNotifier<int> _tabIndexIconButton = ValueNotifier(0);
  final ValueNotifier<int> _tabIndexUpdateProgrammatically = ValueNotifier(0);

  List<String> get _listTextTabToggle =>
      ["Tab A (10)", "Tab B (6)", "Tab C (9)"];

  List<String> get _listTextSelectedToggle =>
      ["Select A (10)", "Select B (6)", "Select C (9)"];

  List<IconData> get _listIconTabToggle => [
        Icons.person,
        Icons.pregnant_woman,
      ];

  List<String> get _listGenderText => ["Male", "Female"];

  List<String> get _listGenderEmpty => ["", ""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Tab Toggle"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 8),
        child: Column(
          children: <Widget>[
            basicTabToggle(),
            ...divider(),
            textWithIcon(),
            ...divider(),
            iconButton(),
            ...divider(),
            updateProgrammatically(),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> divider() => [
        SizedBox(height: heightInPercent(3, context)),
        const Divider(thickness: 2),
        SizedBox(height: heightInPercent(3, context)),
      ];

  Widget basicTabToggle() => Column(
        children: [
          /// Basic Toggle Sample
          SizedBox(height: heightInPercent(3, context)),
          const Text(
            "Basic Tab Toggle",
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: heightInPercent(3, context)),
          ValueListenableBuilder(
            valueListenable: _tabIndexBasicToggle,
            builder: (context, currentIndex, _) {
              return FlutterToggleTab(
                // width in percent
                width: 90,
                borderRadius: 30,
                height: 50,
                selectedIndex: currentIndex,
                selectedBackgroundColors: const [
                  Colors.blue,
                  Colors.blueAccent,
                ],
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                unSelectedTextStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                labels: _listTextTabToggle,
                selectedLabelIndex: (index) {
                  _tabIndexBasicToggle.value = index;
                },
                isScroll: false,
              );
            },
          ),
          TextButton(
            onPressed: () {
              _tabIndexBasicToggle.value = 2;
            },
            child: const Text("Change to Index 2"),
          ),
          SizedBox(height: heightInPercent(3, context)),
          ValueListenableBuilder(
            valueListenable: _tabIndexBasicToggle,
            builder: (context, currentIndex, _) {
              return Text(
                "Index selected : $currentIndex",
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      );

  Widget textWithIcon() => Column(
        children: [
          /// Text with icon sample
          SizedBox(height: heightInPercent(3, context)),
          const Text(
            "Text With Icon",
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Select your sex : ",
                  style: TextStyle(fontSize: 20),
                ),
                ValueListenableBuilder(
                  valueListenable: _tabIndexTextWithIcon,
                  builder: (context, currentIndex, _) {
                    return FlutterToggleTab(
                      width: 50,
                      borderRadius: 15,
                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      unSelectedTextStyle: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      labels: _listGenderText,
                      icons: _listIconTabToggle,
                      selectedIndex: currentIndex,
                      selectedLabelIndex: (index) {
                        _tabIndexTextWithIcon.value = index;
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          /// Icon with Text Button Sample
          SizedBox(height: heightInPercent(3, context)),
          ValueListenableBuilder(
            valueListenable: _tabIndexTextWithIcon,
            builder: (context, currentIndex, _) {
              return Text(
                "Selected sex : ${_listGenderText[currentIndex]} ",
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      );

  Widget iconButton() => Column(
        children: [
          /// Icon button sample
          const Text(
            "With Icon Only and Implement margin for selected item",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Select your sex : ",
                  style: TextStyle(fontSize: 20),
                ),
                ValueListenableBuilder(
                  valueListenable: _tabIndexIconButton,
                  builder: (context, currentIndex, _) {
                    return FlutterToggleTab(
                      width: 40,
                      borderRadius: 15,
                      selectedIndex: currentIndex,
                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      unSelectedTextStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      labels: _listGenderEmpty,
                      icons: _listIconTabToggle,
                      iconSize: 40,
                      selectedLabelIndex: (index) {
                        _tabIndexIconButton.value = index;
                      },
                      marginSelected: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _tabIndexIconButton,
            builder: (context, currentIndex, _) {
              return Text(
                "Selected sex index: $currentIndex",
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      );

  Widget updateProgrammatically() => Column(
        children: [
          const Text(
            "Update selected programmatically  ",
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Select your sex : ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: heightInPercent(3, context)),
                ValueListenableBuilder(
                  valueListenable: _tabIndexUpdateProgrammatically,
                  builder: (context, currentIndex, _) {
                    return FlutterToggleTab(
                      width: 85,
                      borderRadius: 15,
                      selectedIndex: currentIndex,
                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      unSelectedTextStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      labels: _listTextSelectedToggle,
                      selectedLabelIndex: (index) {
                        _tabIndexUpdateProgrammatically.value = index;
                      },
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    _tabIndexUpdateProgrammatically.value = 2;
                  },
                  child: const Text("Select C"),
                )
              ],
            ),
          ),
          SizedBox(height: heightInPercent(3, context)),
          ValueListenableBuilder(
            valueListenable: _tabIndexUpdateProgrammatically,
            builder: (context, currentIndex, _) {
              return Text(
                "Selected sex index: $currentIndex ",
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      );
}
