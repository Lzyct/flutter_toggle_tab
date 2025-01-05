part of 'flutter_toggle_tab.dart';

class DataTab {
  final String? title;
  final IconData? icon;
  final Widget? counterWidget;
  bool isSelected;

  DataTab({
    this.title,
    this.isSelected = false,
    this.icon,
    this.counterWidget,
  });
}
