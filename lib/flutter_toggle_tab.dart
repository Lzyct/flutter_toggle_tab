// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/button_tab.dart';
import 'package:flutter_toggle_tab/data_tab.dart';
import 'package:flutter_toggle_tab/helper.dart';

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
    super.key,
    required this.labels,
    required this.selectedLabelIndex,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
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
  });

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
  final TextStyle? selectedTextStyle;
  final TextStyle? unSelectedTextStyle;
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
  final ValueNotifier<List<DataTab>> _labelsNotifier = ValueNotifier([]);

  /// Set default selected for first build
  void _setDefaultSelected() {
    /// loops label from widget labels
    for (int x = 0; x < widget.labels.length; x++) {
      _labelsNotifier.value
          .add(DataTab(title: widget.labels[x], isSelected: false));
    }
  }

  @override
  void initState() {
    super.initState();

    /// init default selected in InitState
    _setDefaultSelected();
    _updateSelected();

    _labelsNotifier.addListener(() {
      _updateSelected();
    });
  }

  /// Update selected when selectedItem changed
  void _updateSelected() {
    /// set all item to false
    for (final item in _labelsNotifier.value) {
      item.isSelected = false;
    }

    /// Update selectedIndex isSelected to True
    _labelsNotifier.value[widget.selectedIndex].isSelected = true;
  }

  @override
  void dispose() {
    _labelsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// update selected when selectedIndex changed
    _updateSelected();

    /// set width to 100% if width is null
    final width = widthInPercent(widget.width ?? 100, context);

    /// Show text error if length less 1
    return widget.labels.length <= 1
        ? const Text(
            "Error : Label should >1",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        : Container(
            width: width,

            /// Default height is 45
            height: widget.height ?? 45,

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
                    : [const Color(0xffe0e0e0), const Color(0xffe0e0e0)],
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),

              /// Handle if shadow is Enable or not
              boxShadow: [if (widget.isShadowEnable) bsInner],
            ),
            child: ValueListenableBuilder(
              valueListenable: _labelsNotifier,
              builder: (context, labels, _) {
                return ListView.builder(
                  itemCount: labels.length,

                  /// Handle if isScroll or not
                  physics: widget.isScroll
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    IconData? icon;

                    // Using try catch to fix error Range array
                    try {
                      icon = widget.icons?[index];
                    } catch (_) {
                      icon = null;
                    }

                    return ButtonsTab(
                      marginSelected: widget.marginSelected,

                      /// If unSelectedBackground is not null
                      /// We check again if it's length only 1
                      /// Using same color for gradients
                      unSelectedColors: widget.unSelectedBackgroundColors !=
                              null
                          ? (widget.unSelectedBackgroundColors!.length == 1
                              ? [
                                  widget.unSelectedBackgroundColors![0],
                                  widget.unSelectedBackgroundColors![0]
                                ]
                              : widget.unSelectedBackgroundColors)
                          : [const Color(0xffe0e0e0), const Color(0xffe0e0e0)],
                      width: width / widget.labels.length,
                      title: labels[index].title,
                      icons: icon,
                      iconSize: widget.iconSize,

                      /// default selectedTextStyle is Theme.of(context).textTheme.bodyMedium
                      selectedTextStyle: widget.selectedTextStyle ??
                          Theme.of(context).textTheme.bodyMedium,

                      /// default unSelectedTextStyle is Theme.of(context).textTheme.bodyMedium
                      unSelectedTextStyle: widget.unSelectedTextStyle ??
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color
                                    ?.withOpacity(0.7),
                              ),
                      isSelected: labels[index].isSelected,

                      /// default borderRadius is 30
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
                          for (int x = 0; x < labels.length; x++) {
                            if (labels[index] == labels[x]) {
                              labels[x].isSelected = true;

                              /// Send value to callback
                              widget.selectedLabelIndex(index);
                            } else {
                              labels[x].isSelected = false;
                            }
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print("err : $e");
                          }
                        }
                      },
                    );
                  },
                );
              },
            ),
          );
  }
}
