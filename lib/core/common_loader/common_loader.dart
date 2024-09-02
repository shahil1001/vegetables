import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';



class CommonLoader extends StatelessWidget {
  bool isLoading;
  double?  opacity;

  CommonLoader({Key? key, required this.isLoading,this.opacity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Container(
        color: Colors.black.withOpacity(opacity??0.4),
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Center(
            child: CupertinoActivityIndicator(
              color: Colors.white,
              radius: 20.w,
              animating: true,
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressCommonLoader extends StatelessWidget {
  final double? value;

  const ProgressCommonLoader({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50.h,
        width: 50.w,
        child: SimpleCircularProgressBar(
          progressStrokeWidth: 5.w,
          backStrokeWidth: 5.w,
          animationDuration: 1,
          progressColors: const [Color(0xFF146CF2), Color(0xFF52EACF)],
          mergeMode: true,
        ),
        // child: const CircularProgressIndicator(color:Color(0xFF52EACF),backgroundColor: Color(0xFF146CF2), ),
      ),
    );
  }

  String getPercentage({required double progress}) {
    var percentageProgress = progress * 100;
    var percentageProgressInt = percentageProgress.toInt();

    return percentageProgressInt.toString();
  }
}
