import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_call_with_mvc/core/constants/common_strings.dart';
import 'package:flutter_api_call_with_mvc/core/routes/app_routes.dart';
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
  // NetworkController().onInit();
  await GetStorage.init();
  // await Firebase.initializeApp();
  // await checkUserFirstTimeLoginOrNot();
  // await Notifications.init();
  runApp(MyApp());
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
            initialRoute: Routes.homeScreen,
            theme: ThemeData(
              scaffoldBackgroundColor: lightColorPalette.backgroundColor,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: lightColorPalette.backgroundColor),
              useMaterial3: true,
              // primarySwatch: lightColorPalette.backgroundColor,
              // primarySwatch: Colors.blue,
              fontFamily: CommonStrings.raleway,
            ),
          );
        });
  }
}

