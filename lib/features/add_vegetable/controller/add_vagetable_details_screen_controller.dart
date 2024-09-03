import 'dart:developer';
import 'dart:io';

import 'package:flutter_api_call_with_mvc/core/common_dialog.dart';
import 'package:flutter_api_call_with_mvc/core/common_functionality/dismiss_keyboard.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_api_call_with_mvc/core/constants/app_strings.dart';
import 'package:flutter_api_call_with_mvc/core/image_resources.dart';
import 'package:flutter_api_call_with_mvc/core/network_utility/api_hitter.dart';
import 'package:flutter_api_call_with_mvc/core/network_utility/app_end_points.dart';
import 'package:flutter_api_call_with_mvc/core/network_utility/dio_exceptions.dart';
import 'package:flutter_api_call_with_mvc/core/auth_provider/auth_provider.dart'
    as provider;
import 'package:flutter_api_call_with_mvc/core/routes/app_routes.dart';

import 'package:flutter_api_call_with_mvc/core/storage/local_storage.dart';
import 'package:flutter_api_call_with_mvc/core/utils/foundation.dart';
import 'package:flutter_api_call_with_mvc/core/utils/ui_utils.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/signup/model/sign_up_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class AddVegetableDetailsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  var apiHitter = ApiHitter();
  final imageUrls = [
    ImageResource.veg1,
    ImageResource.veg2,
    ImageResource.veg3,
  ];

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  var currentIndex = 0.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController moqController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountedPriceController =
      TextEditingController();

  void addProduct() {}

  Future addVegetablesList() async {
    isLoading.value = true;
    try {
      var token = await Prefs.read(Prefs.userToken);

      var formData = dio.FormData.fromMap({
        "user_login_token": token,
        "name": nameController.text.trim(),
        "moq": moqController.text.trim(),
        "price": priceController.text.trim(),
        "discounted_price": discountedPriceController.text.trim(),
      });

      dio.Response response = await apiHitter.postApii(
        endPoint: EndPoints.addProductsList,
        body: formData,
      );

      // Ensure response.data is treated as a List<dynamic>
      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.offAllNamed(Routes.homeScreen);
        showToast("Product is created successfully");

        // log("vegetableList___${vegetables.length}");
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      print("Errorrrr>> ${e.toString()}");
      // Clear the list on error
    } finally {
      isLoading.value = false;
    }
  }
}
