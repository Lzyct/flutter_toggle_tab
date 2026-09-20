part of 'flutter_toggle_tab.dart';

/// Describes the content of one [FlutterToggleTab] item.
class DataTab {
  /// Creates a tab descriptor.
  ///
  /// A tab can contain a [title], an [icon], a [counterWidget], or a
  /// combination of those values.
  DataTab({this.title, this.isSelected = false, this.icon, this.counterWidget});

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
