part of 'flutter_toggle_tab.dart';

/// This constant function to distribute reuse function
double _widthInPercent(double percent, BuildContext context) {
  final toDouble = percent / 100;
  return MediaQuery.sizeOf(context).width * toDouble;
}

List<Color> _normalizeGradientColors(
  List<Color>? colors,
  List<Color> fallback,
) {
  if (colors == null || colors.isEmpty) return fallback;
  if (colors.length == 1) return [colors.first, colors.first];
  return colors;
}

const BoxShadow _bsInner = BoxShadow(
  color: Colors.black12,
  offset: Offset(0.0, 1.5),
  blurRadius: 1.0,
  spreadRadius: -1.0,
);
const BoxShadow _bsOuter = BoxShadow(
  color: Colors.black12,
  offset: Offset(0.0, 1.5),
  blurRadius: 1.0,
  spreadRadius: 1.0,
);

const BoxDecoration _bdHeader = BoxDecoration(boxShadow: [_bsOuter]);
