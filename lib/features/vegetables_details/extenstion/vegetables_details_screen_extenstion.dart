import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/core/asset_widget/common_image_widget.dart';
import 'package:flutter_api_call_with_mvc/core/common_button/common_button.dart';
import 'package:flutter_api_call_with_mvc/core/common_button/custom_icon_button.dart';
import 'package:flutter_api_call_with_mvc/core/common_container/border_container.dart';
import 'package:flutter_api_call_with_mvc/core/constants/app_strings.dart';
import 'package:flutter_api_call_with_mvc/core/gradient_txt.dart';
import 'package:flutter_api_call_with_mvc/core/image_resources.dart';
import 'package:flutter_api_call_with_mvc/core/text/app_text_widget.dart';
import 'package:flutter_api_call_with_mvc/core/textfields/app_common_text_form_field.dart';
import 'package:flutter_api_call_with_mvc/core/utils/foundation.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_details/screen/vegetables_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_color_palette.dart';

extension VegetablesListScreenExtenstion on VegetablesDetailsScreen {
  Widget buildFavoriteButton() {
    return Container(
      width: 68.w,
      height: 38.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child:  ElevatedButton.icon(
        onPressed: () {
          // Handle add to cart action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C853),
          // Green color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding:
          const EdgeInsets.symmetric(vertical: 16.0),
        ),
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: 24, // Exact size as shown in the image
        ),
        label: const Text(
          'ADD TO CART',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}

