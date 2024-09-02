import 'package:flutter_api_call_with_mvc/features/vegetables_details/controller/home_screen_controller.dart';
import 'package:get/get.dart';

class VegetablesDetailsScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<VegetablesDetailsScreenController>(() => VegetablesDetailsScreenController());
  }

}