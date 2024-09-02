import 'dart:developer';

import 'package:get/get.dart';

class VegetablesDetailsScreenController extends GetxController {
  late String title;
  late double price;
  late String imageUrl;

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
    log("imageUrl---${imageUrl}");
  }
}