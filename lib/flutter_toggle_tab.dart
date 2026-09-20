/// A library for building controlled, customizable toggle-tab interfaces.
library;

import 'dart:math' as math;

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
    this.isAdaptiveWidth = false,
    this.adaptiveTabPadding = const EdgeInsets.symmetric(horizontal: 16),
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
                    begin: begin,
                    end: end,
                    marginSelected: marginSelected ?? EdgeInsets.zero,
                    isInnerShadowEnable: isInnerShadowEnable,
                    animationDuration: animationDuration,
                    animationCurve: animationCurve,
                    padding: adaptiveTabPadding,
                    isScroll: isScroll,
                  )
                : Stack(
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
                            child: _SelectedTabIndicator(
                              width: effectiveWidth / dataTabs.length,
                              height: effectiveHeight,
                              margin: marginSelected ?? EdgeInsets.zero,
                              radius: effectiveBorderRadius,
                              colors: selectedColors,
                              begin: begin,
                              end: end,
                              isShadowEnable: isInnerShadowEnable,
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

class _SelectedTabIndicator extends StatelessWidget {
  const _SelectedTabIndicator({
    required this.width,
    required this.height,
    required this.margin,
    required this.radius,
    required this.colors,
    required this.begin,
    required this.end,
    required this.isShadowEnable,
  });

  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final double radius;
  final List<Color> colors;
  final Alignment? begin;
  final Alignment? end;
  final bool isShadowEnable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const ValueKey('flutter-toggle-tab-indicator'),
      width: width,
      height: height,
      child: Padding(
        padding: margin,
        child: DecoratedBox(
          decoration: (isShadowEnable ? _bdHeader : const BoxDecoration())
              .copyWith(
                borderRadius: BorderRadius.circular(radius),
                gradient: LinearGradient(
                  begin: begin ?? Alignment.topCenter,
                  end: end ?? Alignment.bottomCenter,
                  colors: colors,
                ),
              ),
        ),
      ),
    );
  }
}

class _AdaptiveTabLayout extends StatefulWidget {
  const _AdaptiveTabLayout({
    required this.dataTabs,
    required this.selectedIndex,
    required this.selectedLabelIndex,
    required this.height,
    required this.radius,
    required this.iconSize,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
    required this.selectedColors,
    required this.begin,
    required this.end,
    required this.marginSelected,
    required this.isInnerShadowEnable,
    required this.animationDuration,
    required this.animationCurve,
    required this.padding,
    required this.isScroll,
  });

  final List<DataTab> dataTabs;
  final int selectedIndex;
  final ValueChanged<int> selectedLabelIndex;
  final double height;
  final double radius;
  final double? iconSize;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final List<Color> selectedColors;
  final Alignment? begin;
  final Alignment? end;
  final EdgeInsetsGeometry marginSelected;
  final bool isInnerShadowEnable;
  final Duration animationDuration;
  final Curve animationCurve;
  final EdgeInsetsGeometry padding;
  final bool isScroll;

  @override
  State<_AdaptiveTabLayout> createState() => _AdaptiveTabLayoutState();
}

class _AdaptiveTabLayoutState extends State<_AdaptiveTabLayout> {
  final GlobalKey _stackKey = GlobalKey();
  var _tabKeys = <GlobalKey>[];
  var _tabGeometries = <_TabGeometry>[];
  var _measurementScheduled = false;

  @override
  void initState() {
    super.initState();
    _syncTabKeys();
  }

  @override
  void didUpdateWidget(covariant _AdaptiveTabLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncTabKeys();
  }

  void _syncTabKeys() {
    if (_tabKeys.length != widget.dataTabs.length) {
      _tabKeys = List.generate(widget.dataTabs.length, (_) => GlobalKey());
      _tabGeometries = [];
    }
  }

  void _scheduleMeasurement() {
    if (_measurementScheduled) return;
    _measurementScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measurementScheduled = false;
      if (!mounted) return;

      final stackBox =
          _stackKey.currentContext?.findRenderObject() as RenderBox?;
      if (stackBox == null || !stackBox.hasSize) return;

      final geometries = <_TabGeometry>[];
      for (final key in _tabKeys) {
        final tabBox = key.currentContext?.findRenderObject() as RenderBox?;
        if (tabBox == null || !tabBox.hasSize) return;
        geometries.add(
          _TabGeometry(
            left: tabBox.localToGlobal(Offset.zero, ancestor: stackBox).dx,
            width: tabBox.size.width,
          ),
        );
      }

      if (!_sameGeometries(_tabGeometries, geometries)) {
        setState(() => _tabGeometries = geometries);
      }
    });
  }

  bool _sameGeometries(List<_TabGeometry> first, List<_TabGeometry> second) {
    if (first.length != second.length) return false;
    for (var index = 0; index < first.length; index++) {
      if ((first[index].left - second[index].left).abs() > 0.01 ||
          (first[index].width - second[index].width).abs() > 0.01) {
        return false;
      }
    }
    return true;
  }

  double _minimumTabWidth(BuildContext context, DataTab tab) {
    final resolvedPadding = widget.padding.resolve(Directionality.of(context));
    var contentWidth = resolvedPadding.horizontal;
    final title = tab.title;

    if (tab.icon != null) {
      contentWidth += widget.iconSize ?? IconTheme.of(context).size ?? 24;
    }
    if (tab.icon != null && title != null && title.isNotEmpty) {
      contentWidth += 4;
    }
    if (title != null && title.isNotEmpty) {
      double measure(TextStyle style) {
        final painter = TextPainter(
          text: TextSpan(text: title, style: style),
          maxLines: 1,
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
        )..layout();
        return painter.width;
      }

      contentWidth += math.max(
        measure(widget.selectedTextStyle),
        measure(widget.unSelectedTextStyle),
      );
    }
    if ((tab.icon != null || (title != null && title.isNotEmpty)) &&
        tab.counterWidget != null) {
      contentWidth += 4;
    }

    return contentWidth;
  }

  @override
  Widget build(BuildContext context) {
    _scheduleMeasurement();
    final hasValidSelection = widget.selectedIndex < widget.dataTabs.length;
    final hasGeometry = _tabGeometries.length == widget.dataTabs.length;
    final geometry = hasGeometry
        ? _tabGeometries[hasValidSelection ? widget.selectedIndex : 0]
        : null;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: widget.isScroll
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      child: Stack(
        key: _stackKey,
        children: [
          if (geometry != null)
            AnimatedPositioned(
              left: geometry.left,
              top: 0,
              width: geometry.width,
              height: widget.height,
              duration: widget.animationDuration,
              curve: widget.animationCurve,
              child: IgnorePointer(
                child: AnimatedOpacity(
                  opacity: hasValidSelection ? 1 : 0,
                  duration: widget.animationDuration,
                  curve: widget.animationCurve,
                  child: _SelectedTabIndicator(
                    width: geometry.width,
                    height: widget.height,
                    margin: widget.marginSelected,
                    radius: widget.radius,
                    colors: widget.selectedColors,
                    begin: widget.begin,
                    end: widget.end,
                    isShadowEnable: widget.isInnerShadowEnable,
                  ),
                ),
              ),
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var index = 0; index < widget.dataTabs.length; index++)
                KeyedSubtree(
                  key: _tabKeys[index],
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: _minimumTabWidth(
                        context,
                        widget.dataTabs[index],
                      ),
                    ),
                    child: _ButtonsTab(
                      height: widget.height,
                      title: widget.dataTabs[index].title,
                      icons: widget.dataTabs[index].icon,
                      iconSize: widget.iconSize,
                      counterWidget: widget.dataTabs[index].counterWidget,
                      selectedTextStyle: widget.selectedTextStyle,
                      unSelectedTextStyle: widget.unSelectedTextStyle,
                      isSelected: index == widget.selectedIndex,
                      radius: widget.radius,
                      padding: widget.padding,
                      onPressed: () => widget.selectedLabelIndex(index),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabGeometry {
  const _TabGeometry({required this.left, required this.width});

  final double left;
  final double width;
}
