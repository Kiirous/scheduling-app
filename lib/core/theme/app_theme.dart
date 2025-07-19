import 'package:flutter/material.dart';

class AppTheme {
  final primary = const Color(0xff6B48FF);
  final secondary = const Color(0xff1EE0CC);

  final gray = const Color(0xffB6C5D1);
  final lightGray = const Color(0xffF0F3F6);
  final white = const Color(0xffFFFFFF);
  final black = const Color(0xff0D3F67);
  final error = const Color(0xffECD6D8);
  final success = const Color(0xffC3E9E9);
  final red = const Color(0xffEB5757);
  final yellow = const Color(0xffF2C94C);

  late final label11 = TextStyle(fontSize: 11, color: black);

  late final label11Bold = TextStyle(
    fontSize: 11,
    color: black,
    fontWeight: FontWeight.bold,
  );

  late final field15 = TextStyle(fontSize: 15, color: black);

  late final body16 = TextStyle(fontSize: 16, color: black);

  late final body16Bold = TextStyle(
    fontSize: 16,
    color: black,
    fontWeight: FontWeight.bold,
  );

  late final heading36Bold = TextStyle(
    fontSize: 36,
    color: black,
    fontWeight: FontWeight.bold,
  );
}
