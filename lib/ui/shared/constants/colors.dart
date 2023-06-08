import 'package:flutter/material.dart';

class AppColors {
  static Color gradientColor1 = HexColor.fromHex('F62EBE');
  static Color gradientColor2 = HexColor.fromHex('AC1AF0');
  static Color socialPink = HexColor.fromHex('F62EBE');
  static Color socialBlue = HexColor.fromHex('2E8AF6');
  static Color darkBlack = HexColor.fromHex('181A1C');
  static Color lightWhite = HexColor.fromHex('ECEBED');
}

Color kDarkColor = Colors.black;
Color kWhiteColor = Colors.white;
Color grey = const Color(0XFF323436);
Color lightGrey = const Color(0XFF727477);

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString'; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
