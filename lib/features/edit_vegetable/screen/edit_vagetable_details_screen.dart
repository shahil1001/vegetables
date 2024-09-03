import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/core/common_functionality/dismiss_keyboard.dart';
import 'package:flutter_api_call_with_mvc/core/common_loader/common_loader.dart';
import 'package:flutter_api_call_with_mvc/features/edit_vegetable/controller/edit_vagetable_details_screen_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditVegetableDetailsScreen extends GetView<EditVegetableDetailsScreenController> {
  EditVegetableDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: Colors.grey[200],
          body: Column(
            children: [
              // Carousel Slider
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider.builder(
                    itemCount: controller.imageUrls.length,
                    itemBuilder: (context, index, realIndex) {
                      return Image.asset(
                        controller.imageUrls[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                    options: CarouselOptions(
                      height: 250.h,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        controller.onPageChanged(index);
                      },
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 40.h,
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.imageUrls.length,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: controller.currentIndex.value == index ? 12.0 : 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentIndex.value == index
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),

              // Scrollable container with the form
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    dismissKeyboard();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    transform: Matrix4.translationValues(0, -20, 0),
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Edit Vegetables Details",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ).marginOnly(top: 20.h),
                          Form(
                            key: controller.formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: controller.nameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Icon(Icons.local_florist),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  TextFormField(
                                    controller: controller.moqController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Minimum Order Quantity (MOQ)',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Icon(Icons.production_quantity_limits),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter MOQ';
                                      }
                                      if (int.tryParse(value) == null || int.parse(value) <= 0) {
                                        return 'Please enter a valid quantity';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  TextFormField(
                                    controller: controller.priceController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Price (€)',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Icon(Icons.euro),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the price';
                                      }
                                      if (double.tryParse(value) == null || double.parse(value) <= 0) {
                                        return 'Please enter a valid price';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  TextFormField(
                                    controller: controller.discountedPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Discounted Price (€)',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Icon(Icons.percent),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the discounted price';
                                      }
                                      if (double.tryParse(value) == null || double.parse(value) <= 0) {
                                        return 'Please enter a valid discounted price';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ).marginOnly(top: 30.h),

                          // Spacer
                          SizedBox(height: 16.h),

                          // Bottom buttons
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            child: Row(
                              children: [
                                // ElevatedButton for "SAVE CHANGES"
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (controller.formKey.currentState!.validate()) {
                                        // Handle save action here
                                        controller.editVegetablesList();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00C853), // Green color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    ),
                                    icon: const Icon(
                                      color: Colors.white,
                                      Icons.save,
                                      size: 24,
                                    ),
                                    label: const Text(
                                      'SAVE CHANGES',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(() => CommonLoader(isLoading: controller.isLoading.value)),
      ],
    );
  }
}
