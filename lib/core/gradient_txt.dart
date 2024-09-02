import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/core/constants/common_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum GradientType {
  linear,
  radial,
}

/// Direction to apply in the gradient.
enum GradientDirection {
  btt,
  ltr,
  rtl,
  ttb,
}

class GradientText extends StatelessWidget {
  final List<Color> colors;
  final GradientDirection? gradientDirection;
  final GradientType gradientType;
  final TextOverflow? overflow;
  final double radius;
  final TextStyle? style;
  final String text;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  final int? maxLines;
  final List<double>? stops;
  final Alignment? begin;
  final Alignment? end;

  const GradientText(
      this.text, {
        required this.colors,
        this.gradientDirection = GradientDirection.ltr,
        this.gradientType = GradientType.linear,
        super.key,
        this.overflow,
        this.radius = 1.0,
        this.style,
        this.textAlign,
        this.stops,
        this.textScaleFactor,
        this.maxLines,
        this.begin,
        this.end,
      }) : assert(
  colors.length >= 2,
  'Colors list must have at least two colors',
  );

  @override
  Widget build(BuildContext context) {
    TextStyle? stl=style!=null?TextStyle(fontSize: style?.fontSize,fontWeight: style?.fontWeight,height: 1.3.w,color:  style?.color,backgroundColor:  style?.backgroundColor,fontStyle:  style?.fontStyle,fontFamily:  style?.fontFamily,decoration:  style?.decoration,overflow:  style?.overflow,letterSpacing:  style?.letterSpacing,background:  style?.background,wordSpacing:  style?.wordSpacing,):null;
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        switch (gradientType) {
          case GradientType.linear:
            final Map<String, Alignment> map = {};
            switch (gradientDirection) {
              case GradientDirection.rtl:
                map['begin'] = Alignment.centerRight;
                map['end'] = Alignment.centerLeft;
              case GradientDirection.ttb:
                map['begin'] = Alignment.topCenter;
                map['end'] = Alignment.bottomCenter;
              case GradientDirection.btt:
                map['begin'] = Alignment.bottomCenter;
                map['end'] = Alignment.topCenter;
              default:
                map['begin'] = Alignment.centerLeft;
                map['end'] = Alignment.centerRight;
            }
            return LinearGradient(
              begin: map['begin']!,
              colors: colors,
              stops: stops,
              end: map['end']!,
            ).createShader(bounds);
          case GradientType.radial:
            return RadialGradient(
              colors: colors,
              radius: radius,
            ).createShader(bounds);
        }
      },
      child: Text(
        text,
        overflow: overflow,
        style: stl != null
            ? stl.copyWith(color: Colors.white)
            : const TextStyle(color: Colors.white),
        textScaleFactor: textScaleFactor,
        textAlign: textAlign,
        maxLines: maxLines,
      ),
    );
  }
}
class GradientTextTwo extends StatelessWidget {
  final List<Color> colors;
  final GradientDirection? gradientDirection;
  final GradientType gradientType;
  final TextOverflow? overflow;
  final double radius;
  final TextStyle? style;
  final String text;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  final int? maxLines;
  final List<double>? stops;
  final Alignment? begin;
  final Alignment? end;

  const GradientTextTwo(
      this.text, {
        required this.colors,
        this.gradientDirection = GradientDirection.ltr,
        this.gradientType = GradientType.linear,
        super.key,
        this.overflow,
        this.radius = 1.0,
        this.style,
        this.textAlign,
        this.stops,
        this.textScaleFactor,
        this.maxLines,
        this.begin,
        this.end,
      }) : assert(
  colors.length >= 2,
  'Colors list must have at least two colors',
  );

  @override
  Widget build(BuildContext context) {

    TextStyle? stl=style!=null?TextStyle(fontSize: style?.fontSize,fontWeight: style?.fontWeight,height: 1.3.w,color:  style?.color,backgroundColor:  style?.backgroundColor,fontStyle:  style?.fontStyle,fontFamily:  style?.fontFamily,decoration:  style?.decoration,overflow:  style?.overflow,letterSpacing:  style?.letterSpacing,background:  style?.background,wordSpacing:  style?.wordSpacing,):null;
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(
          begin: begin??Alignment.centerLeft,
          end:  end??Alignment.centerRight,
          colors: colors,
        ).createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child:  Text(
          text,
          overflow: overflow,
          style: TextStyle(
              fontSize: stl?.fontSize??13.sp,
              fontWeight: stl?.fontWeight??FontWeight.normal,
              fontFamily:  stl?.fontFamily??CommonStrings.raleway,
              overflow:  style?.overflow,
              decoration: style?.decoration,
              fontStyle: stl?.fontStyle,
              height: 1.3.h
          ),
          textAlign: textAlign??TextAlign.start,
          maxLines: maxLines,
        )
    );
  }
}

