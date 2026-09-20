import 'package:flutter/services.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

abstract final class ExampleKeys {
  static const basicToggle = Key('basic-toggle');
  static const basicResult = Key('basic-result');
  static const counterToggle = Key('counter-toggle');
  static const counterResult = Key('counter-result');
  static const textWithIconToggle = Key('text-with-icon-toggle');
  static const textWithIconResult = Key('text-with-icon-result');
  static const iconOnlyToggle = Key('icon-only-toggle');
  static const iconOnlyResult = Key('icon-only-result');
  static const programmaticToggle = Key('programmatic-toggle');
  static const programmaticResult = Key('programmatic-result');
  static const selectProgrammatically = Key('select-programmatically');
  static const adaptiveToggle = Key('adaptive-toggle');
  static const adaptiveResult = Key('adaptive-result');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(1);
  final ValueNotifier<int> _tabIndexBasicToggleCounter = ValueNotifier(1);
  final ValueNotifier<int> _tabIndexTextWithIcon = ValueNotifier(0);
  final ValueNotifier<int> _tabIndexIconButton = ValueNotifier(0);
  final ValueNotifier<int> _tabIndexUpdateProgrammatically = ValueNotifier(0);
  final ValueNotifier<int> _tabIndexAdaptive = ValueNotifier(0);

  List<DataTab> get _listTextTabToggle => [
    DataTab(title: "Tab A (10)"),
    DataTab(title: "Tab B (5)"),
    DataTab(title: "Tab C (19)"),
  ];

  late final _listTextTabToggleCounter = [
    DataTab(
      title: "Tab A",
      counterWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              "1",
              style: TextTheme.of(context).labelSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
    DataTab(title: "Tab B (5)"),
    DataTab(title: "Tab C (19)"),
  ];

  List<DataTab> get _listTextSelectedToggle => [
    DataTab(title: "Select A (10)"),
    DataTab(title: "Select B (5)"),
    DataTab(title: "Select C (19)"),
  ];

  List<DataTab> get _listIconTabToggle => [
    DataTab(icon: Icons.person),
    DataTab(icon: Icons.pregnant_woman),
  ];

  List<DataTab> get _listGenderText => [
    DataTab(title: "Male", icon: Icons.person),
    DataTab(title: "Female", icon: Icons.pregnant_woman),
  ];

  List<DataTab> get _listAdaptiveTabs => [
    DataTab(title: 'AAAA'),
    DataTab(title: 'AAAAAAAAAAAAAAA'),
  ];

  @override
  void dispose() {
    _tabIndexBasicToggle.dispose();
    _tabIndexBasicToggleCounter.dispose();
    _tabIndexTextWithIcon.dispose();
    _tabIndexIconButton.dispose();
    _tabIndexUpdateProgrammatically.dispose();
    _tabIndexAdaptive.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Tab Toggle"), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 8),
        child: Column(
          children: <Widget>[
            _basicTabToggle(),
            ..._divider(),
            _adaptiveTabToggle(),
            ..._divider(),
            _basicTabToggleWithCounter(),
            ..._divider(),
            _textWithIcon(),
            ..._divider(),
            _iconButton(),
            ..._divider(),
            _updateProgrammatically(),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _divider() => [
    SizedBox(height: heightInPercent(3, context)),
    const Divider(thickness: 2),
    SizedBox(height: heightInPercent(3, context)),
  ];

  Widget _basicTabToggle() => Column(
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
            key: ExampleKeys.basicToggle,
            // width in percent
            width: 90,
            borderRadius: 30,
            height: 50,
            selectedIndex: currentIndex,
            selectedBackgroundColors: const [Colors.blue, Colors.blueAccent],
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
            dataTabs: _listTextTabToggle,
            selectedLabelIndex: (index) => _tabIndexBasicToggle.value = index,
            isScroll: false,
          );
        },
      ),
      TextButton(
        onPressed: () => _tabIndexBasicToggle.value = 2,
        child: const Text("Change to Index 2"),
      ),
      SizedBox(height: heightInPercent(3, context)),
      ValueListenableBuilder(
        valueListenable: _tabIndexBasicToggle,
        builder: (context, currentIndex, _) => Text(
          "Index selected : $currentIndex",
          key: ExampleKeys.basicResult,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    ],
  );

  Widget _basicTabToggleWithCounter() => Column(
    children: [
      /// Basic Toggle Sample
      SizedBox(height: heightInPercent(3, context)),
      const Text(
        "Basic Tab Toggle with Counter Widget",
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      ),
      SizedBox(height: heightInPercent(3, context)),
      ValueListenableBuilder(
        valueListenable: _tabIndexBasicToggleCounter,
        builder: (context, currentIndex, _) {
          return FlutterToggleTab(
            key: ExampleKeys.counterToggle,
            // width in percent
            width: 90,
            borderRadius: 30,
            height: 50,
            selectedIndex: currentIndex,
            selectedBackgroundColors: const [Colors.blue, Colors.blueAccent],
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
            dataTabs: _listTextTabToggleCounter,
            selectedLabelIndex: (index) =>
                _tabIndexBasicToggleCounter.value = index,
            isScroll: false,
          );
        },
      ),
      TextButton(
        onPressed: () => _tabIndexBasicToggleCounter.value = 0,
        child: const Text("Change to Index 0"),
      ),
      SizedBox(height: heightInPercent(3, context)),
      ValueListenableBuilder(
        valueListenable: _tabIndexBasicToggleCounter,
        builder: (context, currentIndex, _) => Text(
          "Index selected : $currentIndex",
          key: ExampleKeys.counterResult,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    ],
  );

  Widget _adaptiveTabToggle() => Column(
    children: [
      const Text(
        'Adaptive Tab Width',
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      ),
      SizedBox(height: heightInPercent(3, context)),
      ValueListenableBuilder(
        valueListenable: _tabIndexAdaptive,
        builder: (context, currentIndex, _) => FlutterToggleTab(
          key: ExampleKeys.adaptiveToggle,
          width: 90,
          dataTabs: _listAdaptiveTabs,
          selectedIndex: currentIndex,
          selectedLabelIndex: (index) => _tabIndexAdaptive.value = index,
          isAdaptiveWidth: true,
        ),
      ),
      ValueListenableBuilder(
        valueListenable: _tabIndexAdaptive,
        builder: (context, currentIndex, _) => Text(
          'Index selected : $currentIndex',
          key: ExampleKeys.adaptiveResult,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    ],
  );

  Widget _textWithIcon() => Column(
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
            const Text("Select your sex : ", style: TextStyle(fontSize: 20)),
            ValueListenableBuilder(
              valueListenable: _tabIndexTextWithIcon,
              builder: (context, currentIndex, _) => FlutterToggleTab(
                key: ExampleKeys.textWithIconToggle,
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
                dataTabs: _listGenderText,
                selectedIndex: currentIndex,
                selectedLabelIndex: (index) =>
                    _tabIndexTextWithIcon.value = index,
              ),
            ),
          ],
        ),
      ),

      /// Icon with Text Button Sample
      SizedBox(height: heightInPercent(3, context)),
      ValueListenableBuilder(
        valueListenable: _tabIndexTextWithIcon,
        builder: (context, currentIndex, _) => Text(
          "Selected sex : ${_listGenderText[currentIndex].title} ",
          key: ExampleKeys.textWithIconResult,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    ],
  );

  Widget _iconButton() => Column(
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
            const Text("Select your sex : ", style: TextStyle(fontSize: 20)),
            ValueListenableBuilder(
              valueListenable: _tabIndexIconButton,
              builder: (context, currentIndex, _) => FlutterToggleTab(
                key: ExampleKeys.iconOnlyToggle,
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
                dataTabs: _listIconTabToggle,
                iconSize: 40,
                selectedLabelIndex: (index) =>
                    _tabIndexIconButton.value = index,
                marginSelected: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
              ),
            ),
          ],
        ),
      ),
      ValueListenableBuilder(
        valueListenable: _tabIndexIconButton,
        builder: (context, currentIndex, _) => Text(
          "Selected sex index: $currentIndex",
          key: ExampleKeys.iconOnlyResult,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    ],
  );

  Widget _updateProgrammatically() => Column(
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
            const Text("Select your sex : ", style: TextStyle(fontSize: 20)),
            SizedBox(height: heightInPercent(3, context)),
            ValueListenableBuilder(
              valueListenable: _tabIndexUpdateProgrammatically,
              builder: (context, currentIndex, _) => FlutterToggleTab(
                key: ExampleKeys.programmaticToggle,
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
                dataTabs: _listTextSelectedToggle,
                selectedLabelIndex: (index) {
                  _tabIndexUpdateProgrammatically.value = index;
                },
              ),
            ),
            TextButton(
              key: ExampleKeys.selectProgrammatically,
              onPressed: () => _tabIndexUpdateProgrammatically.value = 2,
              child: const Text("Select C"),
            ),
          ],
        ),
      ),
      SizedBox(height: heightInPercent(3, context)),
      ValueListenableBuilder(
        valueListenable: _tabIndexUpdateProgrammatically,
        builder: (context, currentIndex, _) => Text(
          "Selected sex index: $currentIndex ",
          key: ExampleKeys.programmaticResult,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    ],
  );

  double heightInPercent(double percent, BuildContext context) {
    final toDouble = percent / 100;
    return MediaQuery.of(context).size.height * toDouble;
  }
}
