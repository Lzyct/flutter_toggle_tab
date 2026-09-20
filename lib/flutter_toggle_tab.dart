/// A library for building controlled, customizable toggle-tab interfaces.
library;

import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

part 'button_tab.dart';
part 'data_tab.dart';
part 'helper.dart';
part 'adaptive_tab_layout.dart';
part 'non_adaptive_tab_layout.dart';
part 'selected_tab_indicator.dart';

/// A customizable, controlled toggle-tab widget.
///
/// Selection is derived from [selectedIndex]. Callers should update that value
/// after [selectedLabelIndex] is invoked. Prefer a [ValueNotifier] with a
/// [ValueListenableBuilder] around this widget so a selection change rebuilds
/// only the toggle subtree.
class FlutterToggleTab extends StatelessWidget {
  /// Creates a controlled toggle tab.
  ///
  /// At least two [dataTabs] are needed to render the control. When a tab is
  /// pressed, [selectedLabelIndex] reports its index; update [selectedIndex]
  /// in the parent to display the new selection.
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
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeInOutCubic,
    this.isAdaptiveWidth = false,
    this.adaptiveTabPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.adaptiveTabAlignment = Alignment.center,
  }) : assert(selectedIndex >= 0, 'selectedIndex must not be negative.');

  /// Size of every icon in logical pixels.
  ///
  /// When omitted, the current icon theme determines the size.
  final double? iconSize;

  /// The selected tab. An out-of-range value renders all tabs unselected.
  final int selectedIndex;

  /// Width as a percentage of the screen width.
  ///
  /// Defaults to `100` and is constrained by the available parent width.
  final double? width;

  /// Height of the toggle control in logical pixels.
  ///
  /// Defaults to `45`.
  final double? height;

  /// Whether the horizontal tab list uses bouncing scroll physics.
  ///
  /// Defaults to `true`. When `false`, user scrolling is disabled.
  final bool isScroll;

  /// Descriptors for the tabs in display order.
  ///
  /// A validation message is rendered when fewer than two items are supplied.
  final List<DataTab> dataTabs;

  /// Gradient colors for the selected tab.
  ///
  /// An empty list uses the theme primary color. A single color is duplicated
  /// to form a valid gradient.
  final List<Color>? selectedBackgroundColors;

  /// Gradient colors for the background behind unselected tabs.
  ///
  /// An empty list uses the default light-grey background. A single color is
  /// duplicated to form a valid gradient.
  final List<Color>? unSelectedBackgroundColors;

  /// Text style used by the selected tab.
  ///
  /// Defaults to the current theme's `bodyMedium` style.
  final TextStyle? selectedTextStyle;

  /// Text style used by unselected tabs.
  ///
  /// Defaults to a partially transparent `bodyMedium` style.
  final TextStyle? unSelectedTextStyle;

  /// Called with the zero-based index of a pressed tab.
  ///
  /// Assign the reported value to the selection source used by [selectedIndex].
  /// A [ValueNotifier] is recommended for narrowly scoped rebuilds.
  final ValueChanged<int> selectedLabelIndex;

  /// Corner radius used by the control and selected tab.
  ///
  /// Defaults to `30`.
  final double? borderRadius;

  /// Starting alignment for selected and unselected gradients.
  ///
  /// Defaults to [Alignment.topCenter].
  final Alignment? begin;

  /// Ending alignment for selected and unselected gradients.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final Alignment? end;

  /// Insets applied only to the selected tab.
  ///
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsets? marginSelected;

  /// Whether the outer control shadow is visible.
  ///
  /// Defaults to `true`.
  final bool isShadowEnable;

  /// Whether the selected tab shadow is visible.
  ///
  /// Defaults to `true`.
  final bool isInnerShadowEnable;

  /// Duration of the sliding selected-tab indicator animation.
  ///
  /// Defaults to 250 milliseconds. Use [Duration.zero] to disable the motion.
  final Duration animationDuration;

  /// Curve used by the sliding selected-tab indicator animation.
  ///
  /// Defaults to [Curves.easeInOutCubic].
  final Curve animationCurve;

  /// Whether every tab sizes itself to its content instead of sharing space.
  ///
  /// When enabled, tabs can have different widths and the control scrolls
  /// horizontally when their combined width exceeds the available width.
  /// Defaults to `false` to preserve equal-width tabs.
  final bool isAdaptiveWidth;

  /// Padding around each tab when [isAdaptiveWidth] is enabled.
  ///
  /// Defaults to 16 logical pixels on the left and right.
  final EdgeInsetsGeometry adaptiveTabPadding;

  /// Alignment of the complete tab surface in adaptive-width mode.
  ///
  /// This alignment is visible when the combined tab width is smaller than
  /// the available control width. Use [AlignmentDirectional.centerStart] or
  /// [AlignmentDirectional.centerEnd] for direction-aware positioning.
  /// Defaults to [Alignment.center].
  final AlignmentGeometry adaptiveTabAlignment;

  @override
  Widget build(BuildContext context) {
    if (dataTabs.length <= 1) {
      return const Text(
        'Error : Label should >1',
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    }

    final desiredWidth = _widthInPercent(width ?? 100, context);
    final selectedColors = _normalizeGradientColors(selectedBackgroundColors, [
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColor,
    ]);
    final unselectedColors = _normalizeGradientColors(
      unSelectedBackgroundColors,
      const [Color(0xffe0e0e0), Color(0xffe0e0e0)],
    );
    final effectiveSelectedTextStyle =
        selectedTextStyle ??
        TextTheme.of(context).bodyMedium ??
        const TextStyle();
    final effectiveUnselectedTextStyle =
        unSelectedTextStyle ??
        (TextTheme.of(context).bodyMedium ?? const TextStyle()).copyWith(
          color: TextTheme.of(context).bodyMedium?.color
              ?.withValues(alpha: 0.7),
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveWidth = constraints.hasBoundedWidth
            ? desiredWidth.clamp(0, constraints.maxWidth).toDouble()
            : desiredWidth;
        final effectiveHeight = height ?? 45;
        final effectiveBorderRadius = borderRadius ?? 30;

        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: isAdaptiveWidth
              ? _AdaptiveTabLayout(
                  dataTabs: dataTabs,
                  selectedIndex: selectedIndex,
                  selectedLabelIndex: selectedLabelIndex,
                  height: effectiveHeight,
                  radius: effectiveBorderRadius,
                  iconSize: iconSize,
                  selectedTextStyle: effectiveSelectedTextStyle,
                  unSelectedTextStyle: effectiveUnselectedTextStyle,
                  selectedColors: selectedColors,
                  unselectedColors: unselectedColors,
                  begin: begin,
                  end: end,
                  marginSelected: marginSelected ?? EdgeInsets.zero,
                  isShadowEnable: isShadowEnable,
                  isInnerShadowEnable: isInnerShadowEnable,
                  animationDuration: animationDuration,
                  animationCurve: animationCurve,
                  padding: adaptiveTabPadding,
                  alignment: adaptiveTabAlignment,
                  isScroll: isScroll,
                )
              : _NonAdaptiveTabLayout(
                  width: effectiveWidth,
                  height: effectiveHeight,
                  radius: effectiveBorderRadius,
                  dataTabs: dataTabs,
                  selectedIndex: selectedIndex,
                  selectedLabelIndex: selectedLabelIndex,
                  iconSize: iconSize,
                  selectedTextStyle: effectiveSelectedTextStyle,
                  unSelectedTextStyle: effectiveUnselectedTextStyle,
                  selectedColors: selectedColors,
                  unselectedColors: unselectedColors,
                  begin: begin,
                  end: end,
                  marginSelected: marginSelected ?? EdgeInsets.zero,
                  isShadowEnable: isShadowEnable,
                  isInnerShadowEnable: isInnerShadowEnable,
                  animationDuration: animationDuration,
                  animationCurve: animationCurve,
                  isScroll: isScroll,
                ),
        );
      },
    );
  }
}
