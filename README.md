# Flutter Tab Toggle

[![pub package](https://img.shields.io/pub/v/flutter_toggle_tab.svg)](https://pub.dev/packages/flutter_toggle_tab)

A Beautiful and Simple Tab/Toggle switch widget. It can be fully customized with desired icons, width, colors, text,
corner radius etc. It also maintains selection state.

## Getting Started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  flutter_toggle_tab: "^latestVersion"
```

Import it:

```dart
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
```

## Usage Examples

### Basic tab/toggle switch

![image](https://github.com/ukieTux/flutter_toggle_tab/blob/master/gifs/basic.gif?raw=true)


``` dart

// Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
FlutterToggleTab
(
  width: 90, // width in percent
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
  dataTabs: _listTextTabToggle,
  selectedLabelIndex: (index) {
    setState(() {
        _tabTextIndexSelected = index;
    });
  },
  isScroll:false,
)
```


---

### Basic tab/toggle switch with Custom Counter Widget

![image](https://github.com/ukieTux/flutter_toggle_tab/blob/master/gifs/basic_with_counter.gif?raw=true)

``` dart

// Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
FlutterToggleTab
(
  width: 90, // width in percent
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
  dataTabs: _listTextTabToggleCounter,
  selectedLabelIndex: (index) {
    setState(() {
        _tabTextIndexSelected = index;
    });
  },
  isScroll:false,
)
```

---


### Basic tab/toggle switch with Icon

![image](https://github.com/ukieTux/flutter_toggle_tab/blob/master/gifs/with_icon_only.gif?raw=true)

```dart
FlutterToggleTab
(
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
  dataTabs: _listGenderText,
  selectedIndex: _tabTextIconIndexSelected,
  selectedLabelIndex: (index) {
    setState(() {
      _tabTextIconIndexSelected = index;
    });
  },
)
```

---
### Basic tab/toggle switch with Icon Only and add margin on selected item


![image](https://user-images.githubusercontent.com/1531684/170535796-814f380d-2640-4489-8598-97f5a24398fd.png)

```dart
FlutterToggleTab
(
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
  dataTabs: _listIconTabToggle,
  selectedLabelIndex: (index) {
    setState(() {
      _tabIconIndexSelected = index;
    });
  },
  marginSelected: EdgeInsets.symmetric(horizontal: 4,vertical:4),
)
```
---


### Update selected tab Programmatically

```dart
FlutterToggleTab
(
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
  dataTabs: _listTextSelectedToggle,
  selectedLabelIndex: (index) {
    setState(() {
      _tabSelectedIndexSelected = index;
    });
  },
)
```

## Available Parameters

| Param                                                                                       | isRequired |
|---------------------------------------------------------------------------------------------|------------|
| **List<DataTab\>** dataTabs                                                                 | Yes        |
| **Function(int)** selectedLabelIndex                                                        | Yes        |
| **TextStyle** selectedTextStyle ***default*:Theme.of(context).textTheme.bodyMedium,**       | No         |
| **TextStyle** unSelectedTextStyle ***default*:Theme.of(context).textTheme.bodyMedium,**     | No         |
| **int** selectedIndex (listener for index selected) *see on example*                        | Yes        |
| **double** width (in Percent of width Screen) ***default*: 100**                            | No         |
| **double** height (double) ***default*: 45**                                                | No         |
| **double** iconSize                                                                         | No         |
| **double** borderRadius (double) ***default* 30**                                           | No         |
| **List<Color\>** selectedBackgroundColors ***default* : [ Theme.of(context).primaryColor]** | No         |
| **List<Color\>** unSelectedBackgroundColors ***default* [ Color(0xffe0e0e0)]**              | No         |
| **Alignment** begin ***default* : Alignment.topCenter**                                     | No         |
| **Alignment** end ***default* : Alignment.bottomCenter**                                    | No         |
| **bool** isScroll ***default* : true**                                                      | No         |
| **EdgeInsets** marginSelected ***default* : EdgeInsets.zero**                               | No         |

---

<table style="border:none; border-collapse:collapse; cellspacing:0; cellpadding:0">
    <tr>
        <td>
           <a href="https://www.linkedin.com/in/lzyct/" target="_blank">
              <img src="https://github.com/ukieTux/ukieTux/blob/master/assets/linkedin.svg" alt="LinkedIn" style="vertical-align:top; margin:4px" height=24>
          </a>
        </td>
        <td>
           <a href = "https://www.upwork.com/freelancers/~01913209d41be922f1?viewMode=1">
              <img src="https://img.shields.io/badge/UpWork-6FDA44?logo=Upwork&logoColor=white" height=24/>
           </a>
        </td>
    </tr>
</table>


<h3 align="center">Buy me coffee if you love my works ☕️</h3>
<p align="center">
  <a href="https://www.buymeacoffee.com/Lzyct" target="_blank">
    <img src="https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg" alt="buymeacoffe" style="vertical-align:top; margin:8px" height="36">
  </a>&nbsp;&nbsp;&nbsp;&nbsp;
   <a href="https://ko-fi.com/Lzyct" target="_blank">
    <img src="https://help.ko-fi.com/system/photos/3604/0095/9793/logo_circle.png" alt="ko-fi" style="vertical-align:top; margin:8px" height="36">
  </a>&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://paypal.me/ukieTux" target="_blank">
    <img src="https://blog.zoom.us/wp-content/uploads/2019/08/paypal.png" alt="paypal" style="vertical-align:top; margin:8px" height="36">
  </a>
  <a href="https://saweria.co/Lzyct" target="_blank">
   <img src="https://1.bp.blogspot.com/-7OuHSxaNk6A/X92QPg8L9kI/AAAAAAAAG0E/lUzKf_uuVP8jCqvXpA7juh_l-TfK2jnbwCLcBGAsYHQ/s16000/SAWERIA.webp" style="vertical-align:top; margin:8px" height="36">
  </a>
</p>
<br><br>
