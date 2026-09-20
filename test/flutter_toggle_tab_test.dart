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

  testWidgets('selected indicator slides toward the newly selected tab', (
    tester,
  ) async {
    final selectedIndex = ValueNotifier(0);
    addTearDown(selectedIndex.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 300,
            child: ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, currentIndex, _) => FlutterToggleTab(
                dataTabs: [
                  DataTab(title: 'First'),
                  DataTab(title: 'Second'),
                ],
                selectedIndex: currentIndex,
                selectedLabelIndex: (index) => selectedIndex.value = index,
                animationDuration: const Duration(milliseconds: 300),
              ),
            ),
          ),
        ),
      ),
    );

    final indicator = find.byKey(
      const ValueKey('flutter-toggle-tab-indicator'),
    );
    final initialX = tester.getCenter(indicator).dx;

    await tester.tap(find.text('Second'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));
    final animatedX = tester.getCenter(indicator).dx;

    await tester.pumpAndSettle();
    final finalX = tester.getCenter(indicator).dx;

    expect(animatedX, greaterThan(initialX));
    expect(animatedX, lessThan(finalX));
  });

  testWidgets('adaptive width follows content and animates indicator size', (
    tester,
  ) async {
    final selectedIndex = ValueNotifier(0);
    addTearDown(selectedIndex.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 400,
            child: ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, currentIndex, _) => FlutterToggleTab(
                dataTabs: [
                  DataTab(title: 'AAAA'),
                  DataTab(title: 'AAAAAAAAAAAAAAA'),
                ],
                selectedIndex: currentIndex,
                selectedLabelIndex: (index) => selectedIndex.value = index,
                isAdaptiveWidth: true,
                animationDuration: const Duration(milliseconds: 300),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final shortButton = find.ancestor(
      of: find.text('AAAA'),
      matching: find.byType(TextButton),
    );
    final longButton = find.ancestor(
      of: find.text('AAAAAAAAAAAAAAA'),
      matching: find.byType(TextButton),
    );
    final initialIndicatorWidth = tester
        .getSize(find.byKey(const ValueKey('flutter-toggle-tab-indicator')))
        .width;
    final backgroundWidth = tester
        .getSize(find.byKey(const ValueKey('flutter-toggle-tab-background')))
        .width;
    final combinedTabWidth =
        tester.getSize(shortButton).width + tester.getSize(longButton).width;

    expect(
      tester.getSize(longButton).width,
      greaterThan(tester.getSize(shortButton).width),
    );
    expect(backgroundWidth, closeTo(combinedTabWidth, 0.01));
    expect(backgroundWidth, lessThan(400));

    await tester.tap(longButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));
    final animatedIndicatorWidth = tester
        .getSize(find.byKey(const ValueKey('flutter-toggle-tab-indicator')))
        .width;

    await tester.pumpAndSettle();
    final finalIndicatorWidth = tester
        .getSize(find.byKey(const ValueKey('flutter-toggle-tab-indicator')))
        .width;

    expect(animatedIndicatorWidth, greaterThan(initialIndicatorWidth));
    expect(animatedIndicatorWidth, lessThan(finalIndicatorWidth));
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
