import 'dart:developer';
import 'dart:io';


import 'package:flutter_api_call_with_mvc/core/common_dialog.dart';
import 'package:flutter_api_call_with_mvc/core/common_functionality/dismiss_keyboard.dart';

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

class EditVegetableDetailsScreenController extends GetxController {
  var apiHitter = ApiHitter();
  late String title;
  late String price;
  // late String imageUrl;
  late String discountedPrice;
  late String moq;
  late String id;
RxBool isLoading=false.obs;
  final imageUrls = [
    ImageResource.veg1,
    ImageResource.veg2,
    ImageResource.veg3,
  ];
  @override
  void onInit() {
    super.onInit();
    getVegetablesList(); // Corrected method name
  }
  void onPageChanged(int index) {
    currentIndex.value = index;
  }
  var currentIndex = 0.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController moqController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountedPriceController = TextEditingController();

  void getVegetablesList() {

      final arguments = Get.arguments as Map<String, dynamic>;
      title = arguments['name'];
      price = arguments['price'];
      // imageUrl = arguments['imageUrl'];
      id = arguments['id'];
      discountedPrice = arguments['discounted_price'];
      moq = arguments['moq'];

      nameController.text=title;
      moqController.text=moq;
      priceController.text=price;
      discountedPriceController.text=discountedPrice;
      log("iddddddd---${id}");

  }
  Future editVegetablesList() async {
    isLoading.value = true;
    try {
      var token = await Prefs.read(Prefs.userToken);

      var formData = dio.FormData.fromMap({
        "user_login_token": token,
        "name": nameController.text.trim(),
        "moq": moqController.text.trim(),
        "price": priceController.text.trim(),
        "discounted_price": discountedPriceController.text.trim(),
        "id":id,
      });

      dio.Response response = await apiHitter.postApii(
        endPoint: EndPoints.editProductsList,
        body: formData,
      );

      // Ensure response.data is treated as a List<dynamic>
      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.offAllNamed(Routes.homeScreen);
        showToast("Product is edited successfully");

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
  Future deleteVegetablesList() async {
    isLoading.value = true;
    try {
      var token = await Prefs.read(Prefs.userToken);

      var formData = dio.FormData.fromMap({
        "user_login_token": token,
        "id":id,
      });

      dio.Response response = await apiHitter.postApii(
        endPoint: EndPoints.deleteProduct,
        body: formData,
      );

      // Ensure response.data is treated as a List<dynamic>
      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.offAllNamed(Routes.homeScreen);
        showToast("Product is deleted successfully");

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