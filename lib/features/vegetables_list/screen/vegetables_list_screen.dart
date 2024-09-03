import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/core/image_resources.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_list/controller/vegetables_list_screen_controller.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_list/extenstion/vegetables_list_screen_extenstion.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VegetablesListScreen extends GetView<HomeScreenController> {
  const VegetablesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          buildBackgroundImage(),
          Padding(
            padding: EdgeInsets.only(top: 45.h, left: 10.w, right: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildBackButton(),
                SizedBox(height: 10.h),
                buildTitle(),
                SizedBox(height: 15.h),
                buildSearchBar(),
                SizedBox(height: 25.h),
                buildCategoryChips(),
                SizedBox(height: 5.h),
                buildSubCategoryChips(),
                Expanded(child: buildVegetableList()),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
      )
    );
  }

}
