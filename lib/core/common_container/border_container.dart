import 'package:flutter_api_call_with_mvc/core/theme/app_color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;
  final double? padding;
  final double horizontalPadding;
  final double verticalPadding;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  final bool enableBoader;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  const BorderContainer({super.key, required this.child,this.padding,this.boxShadow,this.leftMargin=0,this.height=null,this.width=null,this.rightMargin=0,this.topMargin=0,this.bottomMargin=0,this.enableBoader=true,this.horizontalPadding=0,this.verticalPadding=0,this.borderRadius,this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    // bg => 293242
    // border cl=> 354258
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
            color:  backgroundColor??lightColorPalette.whiteColor,
            borderRadius:
            BorderRadius.circular(borderRadius??7.r),
            border:  enableBoader?Border.all(
                width: 0.6.w,
                color: lightColorPalette.grey):null),
        padding: padding!=null?EdgeInsets.all(padding??0):horizontalPadding==0&&verticalPadding==0?EdgeInsets.all(0):EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
        margin: EdgeInsets.only(left: leftMargin??0,right: rightMargin??0,top: topMargin??0,bottom: bottomMargin??0),
        child: child);
  }
}