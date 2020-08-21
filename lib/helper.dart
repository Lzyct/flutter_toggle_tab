import 'package:flutter/material.dart';

/// This constant function to distribute reuse function

widthInPercent(double percent, BuildContext context) {
  var toDouble = percent / 100;
  return MediaQuery.of(context).size.width * toDouble;
}

heightInPercent(double percent, BuildContext context) {
  var toDouble = percent / 100;
  return MediaQuery.of(context).size.height * toDouble;
}

const BoxShadow bsInner = BoxShadow(
  color: Colors.black12,
  offset: const Offset(0.0, 1.5),
  blurRadius: 1.0,
  spreadRadius: -1.0,
);
const BoxShadow bsOuter = BoxShadow(
  color: Colors.black12,
  offset: const Offset(0.0, 1.5),
  blurRadius: 1.0,
  spreadRadius: 1.0,
);

const BoxDecoration bdHeader = BoxDecoration(boxShadow: [bsOuter]);
