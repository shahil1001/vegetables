
import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/core/asset_widget/common_image_widget.dart';
import 'package:flutter_api_call_with_mvc/core/image_resources.dart';
import 'package:flutter_api_call_with_mvc/core/text/app_text_widget.dart';
import 'package:flutter_api_call_with_mvc/core/theme/app_color_palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommonButton extends StatelessWidget {
  final Color? bgColor;
  final String txt;
  final bool? isEnable;
  final bool? isIconEnable;
  final double? radius;
  final double? elevation;
  final double vertical;
  final double horizontal;
  final double? minWidth;
  final double? minHeight;
  final VoidCallback onPress;
  final VoidCallback? onLongPress;
  final TextStyle? style;
  // final ShowImagePositionAt? type;
  final MainAxisAlignment? mainAxisAlignment;
  final double? spaceBetween;
  final String? image;
  final bool? needStyle;
  final bool? showArrow;
  final bool verifiedInvestorBtn;
  final BorderSide? border;

  const CommonButton(
      {Key? key,
      this.bgColor,
      required this.txt,
      this.radius,
      this.elevation = 0.0,
      this.vertical = 18.0,
      this.horizontal = 0.0,
      this.minWidth = double.infinity,
      this.isEnable = true,
      this.isIconEnable = true,
      this.style,
      this.needStyle,
      this.mainAxisAlignment,
      this.spaceBetween,
      this.minHeight,
      this.image,
      this.verifiedInvestorBtn=false,
      required this.onPress,
       this.onLongPress,
      // this.type = ShowImagePositionAt.none,
      this.showArrow,
      this.border,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: minWidth,
      height: minHeight?? 50.h,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          top: 0,
          bottom: 0,
          left: horizontal,
          right: horizontal
      ),
      decoration: BoxDecoration(
        gradient:   LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: verifiedInvestorBtn==false?[Color(0xFF003F79),Color(0xFF00ACDB)]:lightColorPalette.commonBtnGradientColor,
        ),
        borderRadius:  BorderRadius.circular(radius ?? 7.r)
      ),
      child: ElevatedButton(

        onPressed: onPress ,
        onLongPress: onLongPress == null
            ? null
            : () {
          onLongPress!();
        },
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          disabledBackgroundColor: lightColorPalette.black.withOpacity(0.50),
          side: border,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 7.r)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          textStyle: style ?? CustomTextTheme.normalTextStyle(),
          splashFactory: isEnable == true ? null : NoSplash.splashFactory,
          elevation: elevation,

          maximumSize: Size(minWidth!, minHeight ?? 45.h),
          minimumSize: Size(minWidth!, minHeight ?? 45.h),
          padding: EdgeInsets.zero
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextWidget(
              text: txt,
              style: style ?? CustomTextTheme.bigTitleStyle(textSize: 15.sp,color: lightColorPalette.whiteColor),
            ).paddingOnly(right: showArrow==true?5.w:0),
            showArrow==true? AssetWidget(
              asset: Asset(type: AssetType.svg, path: ImageResource.rightArrow),
              boxFit: BoxFit.cover,
              width: 18.w,
              height: 18.w,
            ): const SizedBox(),
          ],
        ),
      ),
    );
  }
}

