import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/core/common_loader/common_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AssetWidget extends StatelessWidget {
  final Asset asset;
  final double? width;
  final File? file;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final String? firstName;
  final String? lastName;
  final String? placeHolder;
  final bool? isCircular;
  final VoidCallback? onClick;
  final bool flip;
  Function(DownloadProgress progress)? percentageCallback;

  AssetWidget(
      {Key? key,
      required this.asset,
      this.width,
      this.file,
      this.firstName,
      this.onClick,
      this.placeHolder = "", //"assets/images/png/user_img.png",
      this.isCircular = false,
      this.lastName,
      this.height,
      this.color,
      this.percentageCallback,
      this.boxFit,
      this.flip = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (asset.type) {
      case AssetType.png:
        return Transform.flip(
            flipX: flip,
            child: Image(
                image: AssetImage(asset.path),
                width: width,
                height: height,
                fit: boxFit,
                color: color,));
      case AssetType.svg:
        return asset.path != ""
            ? Transform.flip(
                flipX: flip,
                child: SvgPicture.asset(
                  asset.path,
                  width: width,
                  height: height,
                  color: color,
                  fit: boxFit ?? BoxFit.fill,
                ))
            : const SizedBox();
      case AssetType.file:
        return asset.file != null
            ? Transform.flip(
                flipX: flip,
                child: Image.file(
                  asset.file!,
                  width: width,
                  height: height,
                  color: color,
                  fit: boxFit ?? BoxFit.fill,
                ))
            : const SizedBox();
      case AssetType.network:
      case AssetType.network:
        // try {
        //   var widget = InkWell(
        //     focusColor: Colors.transparent,
        //     hoverColor: Colors.transparent,
        //     splashColor: Colors.transparent,
        //     highlightColor: Colors.transparent,
        //     child: CachedNetworkImage(
        //       key: UniqueKey(),
        //       height: height,
        //       width: width,
        //       imageUrl: asset.path,
        //       fit: boxFit ?? BoxFit.cover,
        //       errorWidget: (context, url, error) {
        //         return const Icon(Icons.broken_image_outlined);
        //       },
        //       imageBuilder: (context, imageProvider) {
        //         // return uiShow(imageProvider, boxFit??BoxFit.cover, radius);
        //         return uiShow(imageProvider);
        //       },
        //       progressIndicatorBuilder: (context, url, downloadProgress) =>
        //           Padding(
        //             padding: EdgeInsets.all(8.0.r),
        //             child: Center(
        //               child: CircularProgressIndicator(
        //                   color: lightColorPalette.black,
        //                   value: downloadProgress.progress),
        //             ),
        //           ),
        //     ),
        //   );
        //
        //   return widget;
        // } catch (e) {
        //   print("Network Image Error : ${e.toString()}");
        //   return const Icon(Icons.broken_image_outlined);
        // }
        try {
          var widget = InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            // child: SizedBox(),
            child: Transform.flip(
                flipX: flip,
                child: CachedNetworkImage(
                  height: height,
                  width: width,
                  imageUrl: asset.path,
                  fit: boxFit ?? BoxFit.cover,
                  imageBuilder: (context, imageProvider) {
                    return uiShow(imageProvider);
                  },
                  errorWidget: (context, url, error) =>
                      loadingWidget(placeHolder: placeHolder),
                  progressIndicatorBuilder: (context, url, progress) {
                    if (percentageCallback != null) {
                      percentageCallback!(progress);
                    }
                    return ProgressCommonLoader(
                      value: progress.progress ?? 0,
                    );
                  },
                )),
          );

          return widget;
        } catch (e) {
          print("Network Image Error : ${e.toString()}");
          return const Icon(Icons.broken_image_outlined);
          return loadingWidget(placeHolder: placeHolder);
        }
    }
  }

  Widget loadingWidget({String? placeHolder}) {
    return placeHolder == null || placeHolder == ""
        ? const SizedBox()
/*        : Shimmer.fromColors(
            baseColor: lightColorPalette.primarySwatch.shade900,
            highlightColor: Colors.transparent,
            child: Container(
              color: lightColorPalette.secondarySwatch.shade300,
              // constraints: BoxConstraints(maxHeight: 234.h,),
            ))*/
    :SizedBox()

    ;
  }
}

enum AssetType { png, svg, file, network }

class Asset {
  String path;
  AssetType type;
  File? file;

  Asset({required this.path, required this.type, this.file});
}

Container uiShow(ImageProvider<Object> imageProvider) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2.r),
      // boxShadow: [
      //   BoxShadow(
      //       color: lightColorPalette.black,
      //       blurRadius: 5.0,
      //       offset: const Offset(2, 2),
      //       spreadRadius: 0),
      // ],
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.fill,
      ),
    ),
  );
}
