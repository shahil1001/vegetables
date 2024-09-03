import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_call_with_mvc/core/constants/common_strings.dart';
import 'package:flutter_api_call_with_mvc/core/routes/app_routes.dart';
import 'package:flutter_api_call_with_mvc/core/storage/local_storage.dart';
import 'package:flutter_api_call_with_mvc/core/theme/app_color_palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/translator/local_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize GetStorage
  await GetStorage.init();

  // Check if the user is already logged in
  final token = Prefs.read(Prefs.userToken);

  // Set the initial route based on the token
  String initialRoute = token != null && token.isNotEmpty
      ? Routes.homeScreen
      : Routes.loginScreen;

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'ProductApp',
          translations: LocalString(),
          locale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          getPages: appPages(),
          initialRoute: initialRoute, // Use the determined initial route here
          theme: ThemeData(
            scaffoldBackgroundColor: lightColorPalette.backgroundColor,
            colorScheme: ColorScheme.fromSeed(
                seedColor: lightColorPalette.backgroundColor),
            useMaterial3: true,
            fontFamily: CommonStrings.raleway,
          ),
        );
      },
    );
  }
}


