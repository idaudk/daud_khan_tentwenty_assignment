import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xff003965);
  static const Color primaryDark = Color(0xff153B64);
  static const Color taggle = Color(0xff07122A);
  static const Color taggleWithOpacity = Color(0x2607122A);
  static final Color taggleWithOpacity05 =
      const Color(0xFF07122A).withOpacity(0.5);

  static const Color text = Color(0xff0B152D);
  static const Color red = Color(0xffDF362D);
  static const Color hint = Color(0xff8698A8);
  static const Color cyan = Color(0xFF4cb6ac);
  static const Color mud = Color(0xFF767574);
  static const Color lightBlue = Color(0xFFcbdacf);

  static const Color textgray = Color(0xff303030);
  static const Color gray = Color(0xFF8698A8);
  static const Color grayF7 = Color(0xFFF7F7F9);

  static const Color yellow = Color(0xffFFBE36);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000); // red color
  static const Color lightGray = Color(0xfff5f5f5);
  static const Color blue = Color(0xFF377DFF);
  static const Color darkBlue = Color(0xFF243443);
  static const Color aqua = Color(0xFF00C5EC);
  static const Color purple = Color(0xFF46286E);
  static const Color green = Color(0xFF52D856);
  static const Color disbledColor = Color(0xFF848895);
  static const Color middleBlack = Color(0xFF58616A);
  static const Color transparent = Colors.transparent; // red color

  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");

  // new colors
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color error = HexColor.fromHex("#e61f34");

  //gradient colors
  static Color gradient1 = Color(0xFFf5ebe4);
  static Color gradient2 = Color(0xFFf9acb6);

  static Color homegradient2 = Color(0xFFe5d6d7);
  static Color homegradient1 = Color(0xFFc1e1d8);
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
