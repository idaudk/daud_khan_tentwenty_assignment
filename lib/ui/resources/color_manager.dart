import 'package:flutter/material.dart';

class ColorManager {
  //APP COLORS
  static const Color primary = Color(0xff61c3f2); 
  static const Color primaryOpacity70 = Color.fromRGBO(97, 196, 242, 0.70); 
  static const Color primaryDark = Color.fromRGBO(58, 125, 156, 1);
  static const Color darkPurple = Color(0xFF2e2739);
  static const Color almostWhite = Color(0xFFf6f6fa);
  static const Color grey = Color(0xFF827d88);
  static const Color lightGrey = Color(0xFFdbdbdf);
  static const Color textformBg = Color(0xFFf2f2f6);
  static const Color pageBg = Color(0xFFf6f6fa);
  static const Color aqua = Color(0xFF15d2bc);
  static const Color pink = Color(0xFFe26ca5);
  static const Color purple = Color(0xFF564ca3);
  static const Color yellow = Color(0xFFcd9d0f);
  static const Color black = Color.fromARGB(255, 0, 0, 0);


//OTHERS
  static const Color text = Color(0xff202c43);
  static const Color white = Color(0xFFFFFFFF);
  // static const Color red = Color(0xffDF362D);
  static const Color error = Color(0xffDF362D);
  static const Color hint = Color(0xff8698A8);
  static const Color textgray = Color(0xff303030);
  static const Color gray = Color(0xFF8698A8);
  static const Color grayF7 = Color(0xFFF7F7F9);
  static const Color disbledColor = Color(0xFF848895);
  static const Color transparent = Colors.transparent;
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
