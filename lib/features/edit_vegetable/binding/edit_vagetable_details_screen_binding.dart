import 'package:flutter_api_call_with_mvc/features/edit_vegetable/controller/edit_vagetable_details_screen_controller.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/signup/controller/signup_controller.dart';
import 'package:get/get.dart';

class EditVegetableDetailsScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditVegetableDetailsScreenController>(() => EditVegetableDetailsScreenController());

  }
}
