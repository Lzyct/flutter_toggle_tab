part of 'flutter_toggle_tab.dart';

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
    required this.unselectedColors,
    required this.begin,
    required this.end,
    required this.marginSelected,
    required this.isShadowEnable,
    required this.isInnerShadowEnable,
    required this.animationDuration,
    required this.animationCurve,
    required this.padding,
    required this.alignment,
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
  final List<Color> unselectedColors;
  final Alignment? begin;
  final Alignment? end;
  final EdgeInsetsGeometry marginSelected;
  final bool isShadowEnable;
  final bool isInnerShadowEnable;
  final Duration animationDuration;
  final Curve animationCurve;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final bool isScroll;

  @override
  State<_AdaptiveTabLayout> createState() => _AdaptiveTabLayoutState();
}

class _AdaptiveTabLayoutState extends State<_AdaptiveTabLayout> {
  final GlobalKey _stackKey = GlobalKey();
  var _tabKeys = <GlobalKey>[];
  final ValueNotifier<List<_TabGeometry>> _tabGeometries = ValueNotifier([]);
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

  @override
  void dispose() {
    _tabGeometries.dispose();
    super.dispose();
  }

  void _syncTabKeys() {
    if (_tabKeys.length != widget.dataTabs.length) {
      _tabKeys = List.generate(widget.dataTabs.length, (_) => GlobalKey());
      _tabGeometries.value = [];
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

      if (!_sameGeometries(_tabGeometries.value, geometries)) {
        _tabGeometries.value = geometries;
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
    return ValueListenableBuilder<List<_TabGeometry>>(
      valueListenable: _tabGeometries,
      builder: (context, geometries, _) {
        final hasValidSelection = widget.selectedIndex < widget.dataTabs.length;
        final hasGeometry = geometries.length == widget.dataTabs.length;
        final geometry = hasGeometry
            ? geometries[hasValidSelection ? widget.selectedIndex : 0]
            : null;

        return LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: widget.isScroll
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Align(
                alignment: widget.alignment,
                child: DecoratedBox(
                  key: const ValueKey('flutter-toggle-tab-background'),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: widget.begin ?? Alignment.topCenter,
                      end: widget.end ?? Alignment.bottomCenter,
                      colors: widget.unselectedColors,
                    ),
                    borderRadius: BorderRadius.circular(widget.radius),
                    boxShadow: [if (widget.isShadowEnable) _bsInner],
                  ),
                  child: Stack(
                    key: _stackKey,
                    children: [
                      if (geometry != null)
                        // For adaptive widths, the indicator uses measured geometry.
                        // Its left edge is the sum of all preceding tab widths and
                        // its width is the selected tab width. AnimatedPositioned
                        // can then interpolate both values on selection changes.
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
                          for (
                            var index = 0;
                            index < widget.dataTabs.length;
                            index++
                          )
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
                                  counterWidget:
                                      widget.dataTabs[index].counterWidget,
                                  selectedTextStyle: widget.selectedTextStyle,
                                  unSelectedTextStyle:
                                      widget.unSelectedTextStyle,
                                  isSelected: index == widget.selectedIndex,
                                  radius: widget.radius,
                                  padding: widget.padding,
                                  onPressed: () =>
                                      widget.selectedLabelIndex(index),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TabGeometry {
  const _TabGeometry({required this.left, required this.width});

  final double left;
  final double width;
}
