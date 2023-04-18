// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/material.dart';

import 'button_tab.dart';
import 'data_tab.dart';
import 'helper.dart';

///*********************************************
/// Created by ukieTux on 22/04/2020 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class FlutterToggleTab extends StatefulWidget {
  /// Define parameter Flutter toggle tab
  /// It's main attribute is available on Flutter Toggle Tab
  /// is Scroll by default is set to Enable
  const FlutterToggleTab({
    Key? key,
    required this.labels,
    required this.selectedLabelIndex,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
    this.height,
    this.icons,
    this.iconSize,
    this.selectedBackgroundColors,
    this.unSelectedBackgroundColors,
    this.width,
    this.borderRadius,
    this.begin,
    this.end,
    required this.selectedIndex,
    this.isScroll = true,
    this.marginSelected,
    this.isShadowEnable = true,
  }) : super(key: key);

  final List<String> labels;
  final List<IconData?>? icons;
  final double? iconSize;
  final int selectedIndex;
  final double? width;
  final double? height;
  final bool isScroll;

//  final BoxDecoration selectedDecoration;
//  final BoxDecoration unSelectedDecoration;
  final List<Color>? selectedBackgroundColors;
  final List<Color>? unSelectedBackgroundColors;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final Function(int) selectedLabelIndex;
  final double? borderRadius;
  final Alignment? begin;
  final Alignment? end;

  final EdgeInsets? marginSelected;
  final bool isShadowEnable;

  @override
  _FlutterToggleTabState createState() => _FlutterToggleTabState();
}

class _FlutterToggleTabState extends State<FlutterToggleTab> {
  List<DataTab> _labels = [];

  /// Set default selected for first build
  void _setDefaultSelected() {
    setState(() {
      /// loops label from widget labels
      for (int x = 0; x < widget.labels.length; x++) {
        _labels.add(DataTab(title: widget.labels[x], isSelected: false));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    /// init default selected in InitState
    _setDefaultSelected();
  }

  /// Update selected when selectedItem changed
  void _updateSelected() {
    setState(() {
      /// set all item to false
      for (final item in _labels) {
        item.isSelected = false;
      }

      /// Update selectedIndex isSelected to True
      _labels[widget.selectedIndex].isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateSelected();

    /// Check if width is null or not
    var width = widget.width != null
        ? widthInPercent(widget.width!, context)
        : widthInPercent(100, context);

    /// Show text error if length less 1
    return widget.labels.length <= 1
        ? Text(
            "Error : Label should >1",
            style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )
        : Container(
            width: width,
            height: widget.height ?? 45,

            /// Default height is 45
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  // Where the linear gradient begins and ends
                  begin: widget.begin ?? Alignment.topCenter,
                  end: widget.end ?? Alignment.bottomCenter,

                  /// If unSelectedBackground is not null
                  /// We check again if it's length only 1
                  /// Using same color for gradients
                  colors: widget.unSelectedBackgroundColors != null
                      ? (widget.unSelectedBackgroundColors!.length == 1
                          ? [
                              widget.unSelectedBackgroundColors![0],
                              widget.unSelectedBackgroundColors![0]
                            ]
                          : widget.unSelectedBackgroundColors!)
                      : [Color(0xffe0e0e0), Color(0xffe0e0e0)],
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),

                /// Handle if shadow is Enable or not
                boxShadow: [if (widget.isShadowEnable) bsInner]),
            child: ListView.builder(
              itemCount: _labels.length,

              /// Handle if isScroll or not
              physics: widget.isScroll
                  ? BouncingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                IconData? icon;

                // Using try catch to fix error Range array
                try {
                  icon = widget.icons?[index];
                } catch (e) {
                  icon = null;
                }

                return ButtonsTab(
                  marginSelected: widget.marginSelected,

                  /// If unSelectedBackground is not null
                  /// We check again if it's length only 1
                  /// Using same color for gradients
                  unSelectedColors: widget.unSelectedBackgroundColors != null
                      ? (widget.unSelectedBackgroundColors!.length == 1
                          ? [
                              widget.unSelectedBackgroundColors![0],
                              widget.unSelectedBackgroundColors![0]
                            ]
                          : widget.unSelectedBackgroundColors)
                      : [Color(0xffe0e0e0), Color(0xffe0e0e0)],
                  width: width / widget.labels.length,
                  title: _labels[index].title,
                  icons: icon,
                  iconSize: widget.iconSize,
                  selectedTextStyle: widget.selectedTextStyle,
                  unSelectedTextStyle: widget.unSelectedTextStyle,
                  isSelected: _labels[index].isSelected,
                  radius: widget.borderRadius ?? 30,

                  /// If selectedBackgroundColors is not null
                  /// We check again if it's length only 1
                  /// Using same color for gradients
                  selectedColors: widget.selectedBackgroundColors != null
                      ? (widget.selectedBackgroundColors!.length == 1
                          ? [
                              widget.selectedBackgroundColors![0],
                              widget.selectedBackgroundColors![0]
                            ]
                          : widget.selectedBackgroundColors)
                      : [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor
                        ],
                  onPressed: () {
                    try {
                      for (int x = 0; x < _labels.length; x++) {
                        setState(() {
                          if (_labels[index] == _labels[x]) {
                            _labels[x].isSelected = true;

                            /// Send value to callback
                            widget.selectedLabelIndex(index);
                          } else
                            _labels[x].isSelected = false;
                        });
                      }
                    } catch (e) {
                      print("err : $e");
                    }
                  },
                );
              },
            ));
  }
}
