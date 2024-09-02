import 'dart:developer';

import 'package:flutter_api_call_with_mvc/core/image_resources.dart';
import 'package:get/get.dart';

class VegetablesDetailsScreenController extends GetxController {
  late String title;
  late String price;
  late String imageUrl;

  final imageUrls = [
    ImageResource.veg1,
    ImageResource.veg2,
    ImageResource.veg3,
  ];

  var currentIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getVegetablesList(); // Corrected method name
  }

// Variables to store passed arguments

  void getVegetablesList() {
    final arguments = Get.arguments as Map<String, dynamic>;
    title = arguments['title'];
    price = arguments['price'];
    imageUrl = arguments['imageUrl'];
    log("imageUrl---${price}");
  }



  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}