import 'package:flutter_api_call_with_mvc/features/login_signup_process/signup/controller/signup_controller.dart';
import 'package:get/get.dart';

class SignUpScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());

  }
}
