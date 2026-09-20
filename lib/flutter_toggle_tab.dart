/// A library for building controlled, customizable toggle-tab interfaces.
library;

import 'package:material_ui/material_ui.dart';

part 'button_tab.dart';
part 'data_tab.dart';
part 'helper.dart';

/// A customizable, controlled toggle-tab widget.
///
/// Selection is derived from [selectedIndex]. Callers should update that value
/// after [selectedLabelIndex] is invoked.
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
        final hasValidSelection = selectedIndex < dataTabs.length;
        final indicatorIndex = hasValidSelection ? selectedIndex : 0;
        final indicatorAlignment = Alignment(
          -1 + (2 * indicatorIndex / (dataTabs.length - 1)),
          0,
        );

        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: begin ?? Alignment.topCenter,
                end: end ?? Alignment.bottomCenter,
                colors: unselectedColors,
              ),
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
              boxShadow: [if (isShadowEnable) _bsInner],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: hasValidSelection ? 1 : 0,
                    duration: animationDuration,
                    curve: animationCurve,
                    child: AnimatedAlign(
                      alignment: indicatorAlignment,
                      duration: animationDuration,
                      curve: animationCurve,
                      child: SizedBox(
                        key: const ValueKey('flutter-toggle-tab-indicator'),
                        width: effectiveWidth / dataTabs.length,
                        height: effectiveHeight,
                        child: Padding(
                          padding: marginSelected ?? EdgeInsets.zero,
                          child: DecoratedBox(
                            decoration:
                                (isInnerShadowEnable
                                        ? _bdHeader
                                        : const BoxDecoration())
                                    .copyWith(
                                      borderRadius: BorderRadius.circular(
                                        effectiveBorderRadius,
                                      ),
                                      gradient: LinearGradient(
                                        begin: begin ?? Alignment.topCenter,
                                        end: end ?? Alignment.bottomCenter,
                                        colors: selectedColors,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: dataTabs.length,
                  physics: isScroll
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final tab = dataTabs[index];

                    return _ButtonsTab(
                      width: effectiveWidth / dataTabs.length,
                      height: effectiveHeight,
                      title: tab.title,
                      icons: tab.icon,
                      iconSize: iconSize,
                      counterWidget: tab.counterWidget,
                      selectedTextStyle: effectiveSelectedTextStyle,
                      unSelectedTextStyle: effectiveUnselectedTextStyle,
                      isSelected: index == selectedIndex,
                      radius: effectiveBorderRadius,
                      onPressed: () => selectedLabelIndex(index),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
