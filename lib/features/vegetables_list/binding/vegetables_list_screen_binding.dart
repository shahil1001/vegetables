import 'package:flutter_api_call_with_mvc/features/vegetables_list/controller/vegetables_list_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }

}