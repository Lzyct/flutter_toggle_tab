import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('renders a validation message when only one tab is provided', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FlutterToggleTab(
          dataTabs: [DataTab(title: 'Only tab')],
          selectedIndex: 0,
          selectedLabelIndex: (_) {},
        ),
      ),
    );

    expect(find.text('Error : Label should >1'), findsOneWidget);
  });

  testWidgets('selection is controlled without mutating caller data', (
    tester,
  ) async {
    final selectedIndex = ValueNotifier(0);
    addTearDown(selectedIndex.dispose);
    final tabs = [DataTab(title: 'First'), DataTab(title: 'Second')];

    await tester.pumpWidget(
      MaterialApp(
        home: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, currentIndex, _) => FlutterToggleTab(
            dataTabs: tabs,
            selectedIndex: currentIndex,
            selectedLabelIndex: (index) => selectedIndex.value = index,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Second'));
    await tester.pump();

    expect(selectedIndex.value, 1);
    expect(tabs.every((tab) => !tab.isSelected), isTrue);
  });

  testWidgets('long labels and empty gradients fit narrow constraints', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 180,
            child: FlutterToggleTab(
              width: 100,
              dataTabs: [
                DataTab(title: 'A very long first tab label'),
                DataTab(title: 'A very long second tab label'),
              ],
              selectedBackgroundColors: const [],
              unSelectedBackgroundColors: const [],
              selectedIndex: 0,
              selectedLabelIndex: (_) {},
              isScroll: false,
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
