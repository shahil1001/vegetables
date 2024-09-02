import 'package:get/get.dart';

extension ConvertExtenstions on double{
  double customRoundAgain() {
    double value = this;

    if (value >= 0) {
      if (value % 1 >= 0.3 && value % 1 <= 0.5) {
        return value.floor() + 0.5;
      } else {
        return value.round().toDouble();
      }
    } else {
      if (value % 1 <= -0.3 && value % 1 >= -0.5) {
        return value.ceil() - 0.5;
      } else {
        return value.round().toDouble();
      }
    }
  }


  double customCeilDouble() {
    double value = this;
    if (value < 0) {
      return value.floorToDouble();
    } else {
      return value.ceilToDouble();
    }
  }
  double customRound() {
    double value = this;
    if (value >= 0) {
      if (value >= 0.6) {
        return value.ceilToDouble();
      } else {
        return 0.5;
      }
    } else {
      if (value >= -0.6) {
        return -0.5;
      } else {
        return value.floorToDouble();
      }
    }
  }
  int customCeilInt() {
    double value = this;

    if (value < 0) {
      return value.floor();
    } else {
      return value.ceil();
    }
  }
  double toExtraRound() {
    double value = this;
    if (value < 0) {
      for (double i = -1; i > -10; i--) {
        if (value >= i - 0.9 && value <= i - 0.1) {
          return i;
        }
      }
    } else {
      for (double i = 1; i < 10; i++) {
        if (value >= i + 0.1 && value <= i + 0.9) {
          return i;
        }
      }
    }

    return value.roundToDouble(); // Default rounding
  }
}

extension StringExtensions on String? {
  String? toStringConversion() {
    if (this == "null" || this == null) return null;
    return this;
  }

  int toIntConversion() {
    var string = this ?? "";
    var afterRemovingMinusSign = string.replaceAll("-", "");
    if (string != "" && string != "null" && afterRemovingMinusSign.isNumericOnly) {
      return int.parse(string);
    }
    return 0;
  }


  double toDoubleConversionWithRoundOff() {
    print('inside for double value is ${this}');
    var string = this ?? "";
    if (string != "" &&
        string != "null" &&
        RegExp(r'\d+([\.]\d+)?$').hasMatch(string)) {
      var stringWithRound = double.parse(string).toStringAsFixed(2);

      return double.parse(stringWithRound);
    }
    return 0.0;
  }




  double toDoubleConversion() {
    var string = this ?? "";
    if (string != "" &&
        string != "null" &&
        RegExp(r'\d+([\.]\d+)?$').hasMatch(string)) {
      return double.parse(string);
    }
    return 0.0;
  }



  bool isEmptyOrNull() {
    // var string = this ?? "";
    var string = stripHtmlIfNeeded(this ?? "").trim();
    if (string == "" && string != "null") {
      return true;
    }
    return false;
  }
}

String stripHtmlIfNeeded(String text) {
// The regular expression is simplified for an HTML tag (opening or
// closing) or an HTML escape. We might want to skip over such expressions
// when estimating the text directionality.
  return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
}
