part of 'flutter_toggle_tab.dart';

/// This constant function to distribute reuse function
double _widthInPercent(double percent, BuildContext context) {
  final toDouble = percent / 100;
  return MediaQuery.of(context).size.width * toDouble;
}

double _heightInPercent(double percent, BuildContext context) {
  final toDouble = percent / 100;
  return MediaQuery.of(context).size.height * toDouble;
}

const BoxShadow bsInner = BoxShadow(
  color: Colors.black12,
  offset: Offset(0.0, 1.5),
  blurRadius: 1.0,
  spreadRadius: -1.0,
);
const BoxShadow bsOuter = BoxShadow(
  color: Colors.black12,
  offset: Offset(0.0, 1.5),
  blurRadius: 1.0,
  spreadRadius: 1.0,
);

const BoxDecoration bdHeader = BoxDecoration(boxShadow: [bsOuter]);
