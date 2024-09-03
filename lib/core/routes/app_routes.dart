import 'package:flutter_api_call_with_mvc/core/constants/common_strings.dart';
import 'package:flutter_api_call_with_mvc/features/add_vegetable/screen/add_vagetable_details_screen.dart';
import 'package:flutter_api_call_with_mvc/features/add_vegetable/binding/add_vagetable_details_screen_binding.dart';
import 'package:flutter_api_call_with_mvc/features/edit_vegetable/binding/edit_vagetable_details_screen_binding.dart';
import 'package:flutter_api_call_with_mvc/features/edit_vegetable/screen/edit_vagetable_details_screen.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/login/binding/login_screen_binding.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/login/screens/login_screen.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/signup/binding/signup_screen_binding.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/signup/screens/signup_screen.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_details/binding/vegetables_details_screen_binding.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_details/screen/vegetables_details_screen.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_list/binding/vegetables_list_screen_binding.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_list/screen/vegetables_list_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  Routes._();

  static const homeScreen = "/homeScreen";
  static const vegetableDetailsScreen = "/vegetableDetailsScreen";
  static const String loginScreen = "/LoginScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String editVegetableScreen = "/editVegetableScreen";
  static const String addVegetableScreen = "/addVegetableScreen";
}

List<GetPage> appPages() => [
      GetPage(
          name: Routes.homeScreen,
          page: () => VegetablesListScreen(),
          binding: HomeScreenBinding()),
  GetPage(
      name: Routes.vegetableDetailsScreen,
      page: () => VegetablesDetailsScreen(),
      binding: VegetablesDetailsScreenBinding()),

  GetPage(
    name: Routes.loginScreen,
    page: () => const LoginScreen(),
    fullscreenDialog: true,
    binding: LoginScreenBinding(),
    transition: CommonStrings.transition,
    transitionDuration:
    const Duration(milliseconds: CommonStrings.transitionDuration),
  ),
  GetPage(
    name: Routes.signUpScreen,
    page: () => const SignUpScreen(),
    fullscreenDialog: true,
    binding: SignUpScreenBinding(),
    transition: CommonStrings.transition,
    transitionDuration:
    const Duration(milliseconds: CommonStrings.transitionDuration),
  ),
  GetPage(
    name: Routes.editVegetableScreen,
    page: () =>  EditVegetableDetailsScreen(),
    fullscreenDialog: true,
    binding: EditVegetableDetailsScreenBinding(),
    transition: CommonStrings.transition,
    transitionDuration:
    const Duration(milliseconds: CommonStrings.transitionDuration),
  ),GetPage(
    name: Routes.addVegetableScreen,
    page: () =>  AddVegetableDetailsScreen(),
    fullscreenDialog: true,
    binding: AddVegetableDetailsScreenBinding(),
    transition: CommonStrings.transition,
    transitionDuration:
    const Duration(milliseconds: CommonStrings.transitionDuration),
  )
    ];
