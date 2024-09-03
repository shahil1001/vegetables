import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/core/constants/common_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColorPalette {
  final Color whiteColor;
  final Color transparentColor;
  final Color backgroundColor;
  final Color black;
  final Color grey;
  final Color hintGrey;
  final Color liteGrey;
  final Color txtLiteGrey;
  final Color skyBlue;
  final Color redDark;
  final Color red;
  final Color lightBlue;
  final Color orange;
  final Color bottomLine;
  final Color greyBorderTrangle;
  final LinearGradient bgGradient;
  final List<Color> commonGradientColor;
  final List<Color> reverseCommonGradientColor;
  final List<Color> commonBtnGradientColor;

  AppColorPalette({
    required this.whiteColor,
    required this.backgroundColor,
    required this.transparentColor,
    required this.black,
    required this.liteGrey,
    required this.txtLiteGrey,
    required this.grey,
    required this.hintGrey,
    required this.bgGradient,
    required this.skyBlue,
    required this.redDark,
    required this.red,
    required this.lightBlue,
    required this.orange,
    required this.bottomLine,
    required this.commonGradientColor,
    required this.reverseCommonGradientColor,
    required this.commonBtnGradientColor,
    required this.greyBorderTrangle,

  });
}

AppColorPalette lightColorPalette = AppColorPalette(
  transparentColor: Colors.transparent,
  backgroundColor: const Color(0xFFFFFFFF),
  whiteColor: Colors.white,
  black: const Color(0xFF575665),
  grey: const Color(0xFF9AA1AB),
  liteGrey: const Color(0xFFEDEDED),
    hintGrey: const Color(0xFF9593A2),
    txtLiteGrey: const Color(0xFF777681),
  skyBlue: const Color(0xFF00ACDB),
    redDark: const Color(0xFFF51F1F),
    red: const Color(0xFFFF0000),
    lightBlue: const Color(0xFFF3F6F9),
    orange: const Color(0xFFEF5B29),
    greyBorderTrangle: const Color(0xFF4B4A52),
    bottomLine: const Color(0xFFDCDCDC),
    commonGradientColor: [Color(0xFF00ACDB),Color(0xFF003F79)],
    reverseCommonGradientColor: [
      // Color(0xFF003F79),
      // Color(0xFF00ACDB),
      Color(0xFF673AB7),  // Deep Purple
      Color(0xFF9575CD),  // Lighter Purple
     // Very Light Purple
       // White // white
    ],
    commonBtnGradientColor: [
      Color(0xFFC830EB),
      Color(0xFF00ACDB),
    ],

  bgGradient: const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF00ACDB),Color(0xFF003F79)],
  )

);


class CustomTextTheme {
  static TextStyle extraBigTitleStyle(
      {Color? color,
        FontWeight? fontWeight,
        double? textSize,
        double? height}) {
    return TextStyle(
      fontSize: textSize ?? 20.sp,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontFamily: CommonStrings.raleway,
      color: color ?? lightColorPalette.black,
      // height: height ?? 1.3.w,
      height: height ?? 1.w,


      //   letterSpacing: 2
    );
  }
  static TextStyle bigTitleStyle(
      {Color? color,
        FontWeight? fontWeight,
        double? textSize,
        double? height}) {
    return TextStyle(
      fontSize: textSize ?? 17.sp,
      fontWeight: fontWeight ?? FontWeight.w600,
      fontFamily: CommonStrings.raleway,
      color: color ?? lightColorPalette.black,
      // height: height ?? 1.3.w,
      height: height ?? 1.w,

      //   letterSpacing: 2
    );
  }

  static TextStyle normalTextStyle(
      {Color? color,
        FontWeight? fontWeight,
        double? textSize,
        bool underscore = false,
        double? height}) {
    return TextStyle(
        fontSize: textSize ?? 13.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontFamily: CommonStrings.raleway,
        color: color ?? lightColorPalette.black,
        // height: height ?? 1.3.w,
        height: height ?? 1.w,

        decorationStyle: underscore ? TextDecorationStyle.solid : null,
        decoration: underscore ? TextDecoration.underline : null,
        decorationColor: underscore ? Colors.white : color);
  }
  static TextStyle headingTextStyle(
      {Color? color,
        FontWeight? fontWeight,
        double? textSize,
        bool underscore = false,
        double? height}) {
    return TextStyle(
        fontSize: textSize ?? 15.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontFamily: CommonStrings.raleway,
        color: color ?? lightColorPalette.black,
        // height: height ?? 1.3.w,
        height: height ?? 1.w,

        decorationStyle: underscore ? TextDecorationStyle.solid : null,
        decoration: underscore ? TextDecoration.underline : null,
        decorationColor: underscore ? Colors.white : color);
  }


  static TextStyle bottomTabs({required Color? color, double? height}) {
    return TextStyle(
      letterSpacing: 0.56,
      fontFamily: CommonStrings.raleway,
      fontSize: 12.w,
      fontWeight: FontWeight.w500,
      height: height ?? 1,
      color: color??lightColorPalette.black,
    );
  }
}

BoxDecoration inputTxtDecoration({required bool focused}) {
  return BoxDecoration(
      color: lightColorPalette.whiteColor,
      border: Border.all(
        color:focused ? lightColorPalette.skyBlue : lightColorPalette.grey,
        width: 0.6.w,
      ),
      borderRadius: BorderRadius.circular(7.r),
    boxShadow:focused ?[
      BoxShadow(
        blurRadius: 2,
        spreadRadius: 1,
        color: lightColorPalette.skyBlue.withOpacity(0.3),
      )
    ]:null
  );
}BoxDecoration searchInputTxtDecoration({required bool focused}) {
  return BoxDecoration(
      color: lightColorPalette.lightBlue,
      border: Border.all(
        color:focused ? lightColorPalette.skyBlue : lightColorPalette.grey,
        width: 0.6.w,
      ),
      borderRadius: BorderRadius.circular(7.r),
    boxShadow:focused ?[
      BoxShadow(
        blurRadius: 2,
        spreadRadius: 1,
        color: lightColorPalette.skyBlue.withOpacity(0.3),
      )
    ]:null
  );
}
List<BoxShadow> commonHomeIconsShadow(){
  return [BoxShadow(
      color: lightColorPalette.black.withOpacity(0.2),
      blurRadius: 3.0,
      offset: const Offset(1, 2),
      spreadRadius: 1.5.w)];
}
List<BoxShadow> commonTransparentIconsShadow(){
  return [BoxShadow(
      color: lightColorPalette.black.withOpacity(0.1),
      blurRadius: 3.0,
      offset: const Offset(1, 2),
      spreadRadius: 1.5.w)];
}

BoxDecoration decorationWithElevationOnly() {
  return BoxDecoration(
      color: lightColorPalette.whiteColor,
      borderRadius: BorderRadius.circular(20.r),
      shape: BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
          blurRadius: 24,
          color: lightColorPalette.black.withOpacity(0.20),
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ],
      border: Border.all(color: lightColorPalette.grey, width: 0.3));
}