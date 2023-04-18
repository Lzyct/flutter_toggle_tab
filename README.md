
# Flutter Tab Toggle 
[![pub package](https://img.shields.io/pub/v/flutter_toggle_tab.svg)](https://pub.dev/packages/flutter_toggle_tab)

A Beautiful and Simple Tab/Toggle switch widget. It can be fully customized with desired icons, width, colors, text, corner radius etc. It also maintains selection state.

## Getting Started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  flutter_toggle_tab: "^latestVersion"
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

```

![Farmers Market Finder Demo](https://github.com/ukieTux/flutter_toggle_tab/blob/master/gifs/basic.gif)

### Basic tab/toggle switch with Icon 

```dart
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

```

![image](https://user-images.githubusercontent.com/1531684/170535796-814f380d-2640-4489-8598-97f5a24398fd.png)


### Basic tab/toggle switch with Icon Only and add margin on selected item

```dart
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
  selectedLabelIndex: (index) {
    setState(() {
      _tabIconIndexSelected = index;
    });
  },
  marginSelected:
    EdgeInsets.symmetric(horizontal: 4, vertical: 4),
),

```

![Farmers Market Finder Demo](https://github.com/ukieTux/flutter_toggle_tab/blob/master/gifs/with_icon_only.gif)

### Update selected tab Programmatically

```dart
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

```


## Available Parameters
| Param                                                                                       | isRequired |
|---------------------------------------------------------------------------------------------|------------|
| **List<String\>** labels                                                                    | Yes        |
| **Function(int)** selectedLabelIndex                                                        | Yes        |
| **TextStyle** selectedTextStyle                                                             | Yes        |
| **TextStyle** unSelectedTextStyle                                                           | Yes        |
| **int** selectedIndex (listener for index selected) *see on example*                        | Yes        |
| **double** width (in Percent of width Screen) ***default*: 100**                            | No         |
| **double** height (double) ***default*: 45**                                                | No         |
| **List<IconData\>** icons (List of IconData)                                                | No         |
| **double** iconSize                                                                         | No         |
| **double** borderRadius (double) ***default* 30**                                           | No         |
| **List<Color\>** selectedBackgroundColors ***default* : [ Theme.of(context).primaryColor]** | No         |
| **List<Color\>** unSelectedBackgroundColors ***default* [ Color(0xffe0e0e0)]**              | No         |
| **Alignment** begin ***default* : Alignment.topCenter**                                     | No         |
| **Alignment** end ***default* : Alignment.bottomCenter**                                    | No         |
| **bool** isScroll ***default* : true**                                                      | No         |
| **EdgeInsets** marginSelected ***default* : EdgeInsets.zero**                               | No         |

---
<h3 align="center">Buy me coffee if you love my works ☕️</h3>
<p align="center">
  <a href="https://ko-fi.com/ukietux" target="_blank">
    <img src="https://help.ko-fi.com/system/photos/3604/0095/9793/logo_circle.png" alt="ko-fi" style="vertical-align:top; margin:8px" height="40">
  </a>&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://www.buymeacoffee.com/ukieTux" target="_blank">
    <img src="https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg" alt="buymeacoffe" style="vertical-align:top; margin:8px" height="40">
  </a>&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://paypal.me/ukieTux" target="_blank">
    <img src="https://blog.zoom.us/wp-content/uploads/2019/08/paypal.png" alt="paypal" style="vertical-align:top; margin:8px" height="40">
  </a>
</p>
<br><br>
