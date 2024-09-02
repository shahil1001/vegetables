import 'package:flutter_api_call_with_mvc/features/login_signup_process/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());

  }
}
