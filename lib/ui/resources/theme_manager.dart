import 'package:flutter/material.dart';
import 'font_manager.dart';
import 'resources.dart';

List<Gradient> kGradientList = [
  const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        ColorManager.grayF7,
        ColorManager.grayF7,
      ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#178BE8'),
    HexColor.fromHex('#9F62FE'),
    HexColor.fromHex('#C312D6'),
    HexColor.fromHex('#511CFF'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#EC0A73'),
    HexColor.fromHex('#873DCF'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#833FFB'),
    HexColor.fromHex('#F851AB'),
    HexColor.fromHex('#FFE227'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#F842CE'),
    HexColor.fromHex('#E23838'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#F8426E'),
    HexColor.fromHex('#4C6EE5'),
    HexColor.fromHex('#38D8E2'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#3137F4'),
    HexColor.fromHex('#09BB98'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#146DE4'),
    HexColor.fromHex('#0E2674'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#FFAB2C'),
    HexColor.fromHex('#911C1C'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#E73238'),
    HexColor.fromHex('#D28E0A'),
    HexColor.fromHex('#47DF4B'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#D3EB3F'),
    HexColor.fromHex('#3FCF43'),
    HexColor.fromHex('#34DFD5'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#32DDE7'),
    HexColor.fromHex('#F38EF5'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#B31A1A'),
    HexColor.fromHex('#170000'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#F3AF00'),
    HexColor.fromHex('#331E00'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#53DE29'),
    HexColor.fromHex('#085343'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#030418'),
    HexColor.fromHex('#1C3BA8'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#1B201F'),
    HexColor.fromHex('#027E7A'),
  ]),
  LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
    HexColor.fromHex('#2B2C2F'),
    HexColor.fromHex('#6E6E6E'),
  ]),
];

class TextThemeProvider extends InheritedWidget {
  final TextTheme tt;
  const TextThemeProvider({super.key, required super.child, required this.tt});

  static TextThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TextThemeProvider>();
  }

  @override
  bool updateShouldNotify(TextThemeProvider oldWidget) {
    return tt != oldWidget.tt;
  }
}

extension ThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ElevatedButtonThemeData get elevatedButtonTheme =>
      Theme.of(this).elevatedButtonTheme;
  InputDecorationTheme get inputDecoration =>
      Theme.of(this).inputDecorationTheme;
}

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.primary),
      primaryColor: ColorManager.primary,
      useMaterial3: true,
      primaryColorLight: ColorManager.primaryOpacity70,
      scaffoldBackgroundColor: ColorManager.white,
      primaryColorDark: ColorManager.primaryDark,
      disabledColor: ColorManager.grey1,
      // ripple color
      splashColor: ColorManager.taggle,
      // will be used incase of disabled button for example
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),
      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primaryOpacity70),

      // elevated button theme

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.cyan,
              disabledForegroundColor: ColorManager.white,
              disabledBackgroundColor: ColorManager.taggleWithOpacity05,
              foregroundColor: Colors.white,
              textStyle: getMediumStyle(
                  fontSize: AppSize.s16.sp, color: ColorManager.red),
              padding: EdgeInsets.symmetric(
                  vertical: AppSize.s16.h, horizontal: AppSize.s20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s50)))),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: ColorManager.yellow,
            textStyle: getMediumStyle(
                fontSize: AppSize.s16.sp, color: ColorManager.white)),
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge:
            getBoldStyle(color: ColorManager.primaryDark, fontSize: 60.sp),
        displayMedium: getRegularStyle(
          color: ColorManager.primaryDark,
          fontSize: FontSize.s36.sp,
        ),
        displaySmall: getRegularStyle(
            color: ColorManager.primary, fontSize: FontSize.s12.sp),
        headlineMedium: getSemiBoldStyle(
            color: ColorManager.text, fontSize: FontSize.s20.sp),
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.text, fontSize: FontSize.s28.sp),
        headlineSmall:
            getBoldStyle(color: ColorManager.text, fontSize: FontSize.s18.sp),
        titleLarge: getSemiBoldStyle(
            color: ColorManager.text, fontSize: FontSize.s22.sp),
        titleMedium: getSemiBoldStyle(
            color: ColorManager.text, fontSize: FontSize.s16.sp),
        titleSmall: getSemiBoldStyle(
            color: ColorManager.text, fontSize: FontSize.s12.sp),
        bodyMedium: getRegularStyle(
            color: ColorManager.text, fontSize: FontSize.s16.sp),
        bodySmall:
            getRegularStyle(color: ColorManager.text, fontSize: AppSize.s12.sp),
        bodyLarge: getRegularStyle(
            color: ColorManager.text, fontSize: FontSize.s22.sp),
        labelMedium:
            getRegularStyle(color: ColorManager.text, fontSize: AppSize.s12.sp),
      ),

      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppSize.s8),
        fillColor: ColorManager.white,
        focusColor: ColorManager.white,

        // hint style
        hintStyle:
            getRegularStyle(color: ColorManager.hint, fontSize: AppSize.s14.sp),

        // label style
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        // error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.transparent, width: AppSize.s0),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s50))),

        // focused border
        focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.transparent, width: AppSize.s0),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s50))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.transparent, width: AppSize.s0),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s50))),
        // focused error border
        focusedErrorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.transparent, width: AppSize.s0),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s50))),
      ));
}
