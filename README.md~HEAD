# Flutter Tab Toggle

A Beautiful and Simple Tab/Toggle switch widget. It can be fully customized with desired icons, width, colors, text, corner radius etc. It also maintains selection state.

## Getting Started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  flutter_toggle_tab: "^0.0.1"
```

Import it:

```dart
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
```

## Usage Examples

### Basic tab/toggle switch
```dart
// Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
FlutterToggleTab(
  // width in percent, to set full width just set to 100
  width: 90,
  borderRadius: 30,
  height: 50,
  initialLabelIndex: 0,
  selectedColor: Colors.blue,
  selectedTextStyle: TextStyle(
	  color: Colors.white,
	  fontSize: 18,
	  fontWeight: FontWeight.w700),
  unSelectedTextStyle: TextStyle(
	  color: Colors.black87,
      fontSize: 14,
      fontWeight: FontWeight.w500),
  labels: ["Tab A (10)", "Tab B (6)", "Tab C (9)"],
  selectedLabelIndex: (index) {
	  setState(() {
		  print("Selected Index $index");
	    });
  },
),
```

GIF Basic

### Basic tab/toggle switch with Icon

```dart
FlutterToggleTab(
  width: 50,
  borderRadius: 15,
  initialLabelIndex: 0,
  selectedTextStyle: TextStyle(
	  color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600),
  unSelectedTextStyle: TextStyle(
	  color: Colors.blue,
      fontSize: 14,
      fontWeight: FontWeight.w400),
  labels: ["Male","Female"],
  icons: [Icons.person,Icons.pregnant_woman],
  selectedLabelIndex: (index) {
	  setState(() {
		  print("selected index $index");
	  });
  },
),
```

GIF With Icon


### Basic tab/toggle switch with Icon Only

```dart
FlutterToggleTab(
  width: 40,
  borderRadius: 15,
  initialLabelIndex: 0,
  selectedTextStyle: TextStyle(
	  color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600),
  unSelectedTextStyle: TextStyle(
	  color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w400),
  labels: ["",""],
  icons: [Icons.person,Icons.pregnant_woman],
  selectedLabelIndex: (index) {
	  setState(() {
	    print("selected index $index");
	  });
  },
```

GIF Icon Only
