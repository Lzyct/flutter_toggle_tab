import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_toggle_tab_example/main.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('basic usage updates the selected index after a tap', (
    tester,
  ) async {
    await _pumpExample(tester);
    final tab = find.descendant(
      of: find.byKey(ExampleKeys.basicToggle),
      matching: find.text('Tab C (19)'),
    );

    await tester.tap(tab);
    await tester.pump();

    expect(_text(tester, ExampleKeys.basicResult), 'Index selected : 2');
  });

  testWidgets('counter usage renders its counter and updates selection', (
    tester,
  ) async {
    await _pumpExample(tester);
    final toggle = find.byKey(ExampleKeys.counterToggle);
    final firstTab = find.descendant(of: toggle, matching: find.text('Tab A'));

    expect(
      find.descendant(of: toggle, matching: find.text('1')),
      findsOneWidget,
    );
    await tester.tap(firstTab);
    await tester.pump();

    expect(_text(tester, ExampleKeys.counterResult), 'Index selected : 0');
  });

  testWidgets('text and icon usage reports the selected label', (tester) async {
    await _pumpExample(tester);
    final femaleTab = find.descendant(
      of: find.byKey(ExampleKeys.textWithIconToggle),
      matching: find.text('Female'),
    );
    await tester.ensureVisible(femaleTab);

    await tester.tap(femaleTab);
    await tester.pump();

    expect(
      _text(tester, ExampleKeys.textWithIconResult),
      'Selected sex : Female ',
    );
  });

  testWidgets('icon-only usage reports the selected icon index', (
    tester,
  ) async {
    await _pumpExample(tester);
    final icons = find.descendant(
      of: find.byKey(ExampleKeys.iconOnlyToggle),
      matching: find.byType(Icon),
    );
    await tester.ensureVisible(icons.last);

    await tester.tap(icons.last);
    await tester.pump();

    expect(_text(tester, ExampleKeys.iconOnlyResult), 'Selected sex index: 1');
  });

  testWidgets('programmatic usage changes selection from its control', (
    tester,
  ) async {
    await _pumpExample(tester);
    final selectButton = find.byKey(ExampleKeys.selectProgrammatically);
    await tester.ensureVisible(selectButton);

    await tester.tap(selectButton);
    await tester.pump();

    expect(
      _text(tester, ExampleKeys.programmaticResult),
      'Selected sex index: 2 ',
    );
  });
}

Future<void> _pumpExample(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(1200, 2400);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  await tester.pumpWidget(const MyApp());
}

String? _text(WidgetTester tester, Key key) {
  return tester.widget<Text>(find.byKey(key)).data;
}
