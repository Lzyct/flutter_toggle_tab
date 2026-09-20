part of 'flutter_toggle_tab.dart';

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
