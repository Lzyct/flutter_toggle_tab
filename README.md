
# Flutter Tab Toggle 
[![Build Status](https://travis-ci.org/dart-lang/flutter_toggle_tab.svg?branch=master)](https://travis-ci.org/dart-lang/flutter_toggle_tab)
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
  // width in percent, to set full width just set to 100  
  width: 90,  
  borderRadius: 30,  
  height: 50,  
  initialIndex:0, 
  selectedColors: [Colors.blue],  
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
	print("Selected Index $index");
  },  
),
```

![Farmers Market Finder Demo](https://github.com/ukieTux/flutter_toggle_tab/blob/master/gifs/basic.gif)

### Basic tab/toggle switch with Icon 

```dart
FlutterToggleTab(  
  width: 50,  
  borderRadius: 15,  
  initialIndex:0, 
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
	print("Selected Index $index");
  },  
),
```

![Farmers Market Finder Demo](https://github.com/ukieTux/flutter_toggle_tab/blob/master/gifs/with_icon.gif)


### Basic tab/toggle switch with Icon Only

```dart
FlutterToggleTab(  
  width: 40,  
  borderRadius: 15,  
  initialIndex:0, 
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
	print("Selected Index $index");
  },
```

![Farmers Market Finder Demo](https://github.com/ukieTux/flutter_toggle_tab/blob/master/gifs/with_icon_only.gif)

### Update selected tab Programmatically

```dart
var _selectedIndex= 0 // you can change selected with update this 
FlutterToggleTab(  
  width: 40,  
  borderRadius: 15,
  initialIndex:0, 
  selectedIndex: _selectedIndex,  
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
	  _selectedIndex = index;
	  print("Selected Index $index");
	});
  },
```


## Available Parameters
| Param | isRequired |
|--|--|
| **List<String\>** labels | Yes |
| **Function(int)** selectedLabelIndex | Yes |
| **TextStyle** selectedTextStyle | Yes |
| **TextStyle** unSelectedTextStyle | Yes |
| **int** selectedIndex (listener for index selected) *see on example* | Yes |
| **double** width (in Percent of width Screen) ***default*: 100** | No |
| **double** height (double) ***default*: 45** | No |
| **List<IconData\>** icons (List of IconData) | No |
| **double** borderRadius (double) ***default* 30**| No |
| **List<Color\>** selectedBackgroundColors ***default* : [ Theme.of(context).primaryColor]**| No |
| **List<Color\>** unSelectedBackgroundColors ***default* [ Color(0xffe0e0e0)]**| No |
| **Alignment** begin ***default* : Alignment.topCenter** | No |
| **Alignment** end ***default* : Alignment.bottomCenter** | No |
| **bool** isScroll ***default* : true** | No |
| **EdgeInsets** marginSelected ***default* : EdgeInsets.zero** | No |

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
