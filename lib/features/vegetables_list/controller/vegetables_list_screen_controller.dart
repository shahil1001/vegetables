import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_api_call_with_mvc/core/common_dialog.dart';
import 'package:flutter_api_call_with_mvc/core/image_resources.dart';

import 'package:flutter_api_call_with_mvc/core/network_utility/api_hitter.dart';
import 'package:flutter_api_call_with_mvc/core/network_utility/app_end_points.dart';
import 'package:flutter_api_call_with_mvc/core/routes/app_routes.dart';
import 'package:flutter_api_call_with_mvc/core/storage/local_storage.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_list/model/vegetable_response_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';


class HomeScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getVegetablesList(); // Corrected method name
  }

  RxList<Vegetable> vegetables = <Vegetable>[].obs; // Use RxList for reactivity
  var apiHitter = ApiHitter();
  RxBool isLoading = false.obs;
  var selectedCategoryIndex = 0.obs;
  var selectedSubCategoryIndex = 0.obs;
  static List<String> sampleImages = [
    ImageResource.veg1,
    ImageResource.veg2,
    ImageResource.veg3,
  ];
  // List of categories
  final categories = [
    'Cabbage and lettuce (14)',
    'Cucumbers and tomatoes',
    'Onions and garlic (8)',
    'Peppers (7)',
    'Potatoes and carrots'
  ];

  void getVegetablesList() async {
    isLoading.value = true;
    try {
      var token = await Prefs.read(Prefs.userToken);
      var formData = dio.FormData.fromMap({
        "user_login_token": token,
      });

      var response = await apiHitter.postApii(
        endPoint: EndPoints.getProductsList,
        body: formData,
      );

      // Ensure response.data is treated as a List<dynamic>
      if (response.data is List) {
        VegetablesListResponseModel productList =
        VegetablesListResponseModel.fromJson(response.data);
        vegetables.value = productList.vegetables;
        // log("vegetableList___${vegetables.length}");
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      print("Errorrrr>> ${e.toString()}");
      vegetables.clear(); // Clear the list on error
    } finally {
      isLoading.value = false;
    }
  }
  logoutFunctionality() {
    showCommonAlertWithTwoActionsDialog(title: "LogOut!", subHeader: "Are you sure you want to logout?", yesPressed: () {
      Prefs.erase();
      Prefs.write(Prefs.userToken, '');
      Get.offAllNamed(Routes.loginScreen);
    },rightButtonTitle: "Logout");
  }

}

