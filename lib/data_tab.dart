part of 'flutter_toggle_tab.dart';

/// Describes the content of one [FlutterToggleTab] item.
class DataTab {
  /// Creates a tab with optional text, icon, and counter content.
  DataTab({this.title, this.icon, this.counterWidget, this.isSelected = false});

  /// Text displayed in the tab.
  final String? title;

  /// Icon displayed before [title].
  final IconData? icon;

  /// Optional widget displayed after [title], such as a badge or counter.
  final Widget? counterWidget;

  /// Retained for backwards compatibility.
  ///
  /// [FlutterToggleTab] derives selection from its `selectedIndex` property and
  /// does not mutate this value.
  bool isSelected;
}
