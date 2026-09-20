part of 'flutter_toggle_tab.dart';

class _NonAdaptiveTabLayout extends StatelessWidget {
  const _NonAdaptiveTabLayout({
    required this.width,
    required this.height,
    required this.radius,
    required this.dataTabs,
    required this.selectedIndex,
    required this.selectedLabelIndex,
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
    required this.isScroll,
  });

  final double width;
  final double height;
  final double radius;
  final List<DataTab> dataTabs;
  final int selectedIndex;
  final ValueChanged<int> selectedLabelIndex;
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
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    final hasValidSelection = selectedIndex < dataTabs.length;
    final indicatorIndex = hasValidSelection ? selectedIndex : 0;

    // Equal-width tabs have evenly spaced centers. Alignment.x is normalized
    // from -1 (left) through 0 (center) to 1 (right), so mapping index 0..n-1
    // onto that range produces x = -1 + (2 * index / (n - 1)).
    final indicatorAlignment = Alignment(
      -1 + (2 * indicatorIndex / (dataTabs.length - 1)),
      0,
    );

    return DecoratedBox(
      key: const ValueKey('flutter-toggle-tab-background'),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin ?? Alignment.topCenter,
          end: end ?? Alignment.bottomCenter,
          colors: unselectedColors,
        ),
        borderRadius: BorderRadius.circular(radius),
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
                child: _SelectedTabIndicator(
                  width: width / dataTabs.length,
                  height: height,
                  margin: marginSelected,
                  radius: radius,
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
                width: width / dataTabs.length,
                height: height,
                title: tab.title,
                icons: tab.icon,
                iconSize: iconSize,
                counterWidget: tab.counterWidget,
                selectedTextStyle: selectedTextStyle,
                unSelectedTextStyle: unSelectedTextStyle,
                isSelected: index == selectedIndex,
                radius: radius,
                onPressed: () => selectedLabelIndex(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
