// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'button_tab.dart';
part 'data_tab.dart';
part 'helper.dart';

/// A custom Flutter toggle tab widget.
class FlutterToggleTab extends StatefulWidget {
  /// Define attribute Widget and State
  /// [dataTabs] is required to set the data of the widget.
  /// [iconSize] is optional to set the size of the icon.
  /// [selectedIndex] is required to set the selected index.
  /// [width] is optional to set the width of the widget.
  /// [height] is optional to set the height of the widget.
  /// [isScroll] is optional to set the scrollable or not.
  ///
  /// [selectedTextStyle] is optional to set the text style of the selected label.
  /// [unSelectedTextStyle] is optional to set the text style of the unselected label.
  /// [selectedBackgroundColors] is optional to set the background color of the selected label.
  /// [unSelectedBackgroundColors] is optional to set the background color of the unselected label.
  /// [selectedLabelIndex] is required to set the selected label index.
  /// [borderRadius] is optional to set the border radius of the widget.
  /// [begin] is optional to set the begin alignment of the gradient.
  /// [end] is optional to set the end alignment of the gradient.
  ///
  /// [marginSelected] is optional to set the margin of the selected label.
  /// [isShadowEnable] is optional to set the shadow of the widget.
  /// [isInnerShadowEnable] is optional to set the shadow of the selected tab.
  const FlutterToggleTab({
    super.key,
    required this.dataTabs,
    required this.selectedLabelIndex,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    this.height,
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
    this.isInnerShadowEnable = true,
  });

  final double? iconSize;
  final int selectedIndex;
  final double? width;
  final double? height;
  final bool isScroll;
  final List<DataTab> dataTabs;

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
  final bool isInnerShadowEnable;

  @override
  _FlutterToggleTabState createState() => _FlutterToggleTabState();
}

class _FlutterToggleTabState extends State<FlutterToggleTab> {
  final ValueNotifier<List<DataTab>> _labelsNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();

    _labelsNotifier.value.addAll(widget.dataTabs);

    _updateSelected();

    _labelsNotifier.addListener(() => _updateSelected());
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
    final width = _widthInPercent(widget.width ?? 100, context);

    /// Show text error if length less 1
    return widget.dataTabs.length <= 1
        ? const Text(
            "Error : Label should >1",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        : SizedBox(
            width: width,

            /// Default height is 45
            height: widget.height ?? 45,

            child: DecoratedBox(
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
                              widget.unSelectedBackgroundColors![0],
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
                        icon = widget.dataTabs[index].icon;
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
                                    widget.unSelectedBackgroundColors![0],
                                  ]
                                : widget.unSelectedBackgroundColors)
                            : [
                                const Color(0xffe0e0e0),
                                const Color(0xffe0e0e0),
                              ],
                        width: width / widget.dataTabs.length,
                        title: labels[index].title,
                        icons: icon,
                        iconSize: widget.iconSize,
                        counterWidget: labels[index].counterWidget,
                        isInnerShadowEnable: widget.isInnerShadowEnable,

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
                                      ?.withValues(alpha: 0.7),
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
                                    widget.selectedBackgroundColors![0],
                                  ]
                                : widget.selectedBackgroundColors)
                            : [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor,
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
            ),
          );
  }
}
