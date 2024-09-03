import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/core/gradient_txt.dart';
import 'package:flutter_api_call_with_mvc/core/image_resources.dart';
import 'package:flutter_api_call_with_mvc/core/routes/app_routes.dart';
import 'package:flutter_api_call_with_mvc/core/text/app_text_widget.dart';
import 'package:flutter_api_call_with_mvc/core/utils/foundation.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_list/screen/vegetables_list_screen.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_list/model/vegetable_response_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

extension VegetablesListScreenExtenstion on VegetablesListScreen {
  Widget buildBackgroundImage() {
    return Positioned(
      top: 0,
      right: 0,
      child: Image.asset(
        ImageResource.topRightIcon, // Replace with your image asset path
        width: 160.w, // Adjust as per your design
        height: 170.h, // Adjust as per your design
        fit: BoxFit.contain,
      ),
    );
  }

  Widget buildBackButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.black),
      onPressed: () {},
    );
  }

  Widget buildTitle() {
    return const Text(
      'Vegetables',
      style: TextStyle(
        color: Colors.deepPurple,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ).marginOnly(left: 8.w);
  }

  Widget buildSearchBar() {
    return Container(
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: const Center(
        child: TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search_rounded, color: Colors.black),
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildCategoryChips() {
    return Obx(() => controller.isLoading.value
        ? buildShimmerCategoryChips()
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              return Row(
                children: List.generate(
                  controller.categories.sublist(0, 3).length,
                  (index) => GestureDetector(
                    onTap: () {
                      controller.selectedCategoryIndex.value = index;
                    },
                    child: CategoryChip(
                      label: controller.categories[index],
                      isSelected:
                          controller.selectedCategoryIndex.value == index,
                    ),
                  ),
                ),
              );
            }),
          ));
  }

  Widget buildSubCategoryChips() {
    return Obx(() => controller.isLoading.value
        ? buildShimmerCategoryChips()
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              return Row(
                children: List.generate(
                  controller.categories.sublist(3).length,
                  (index) => GestureDetector(
                    onTap: () {
                      controller.selectedSubCategoryIndex.value = index;
                    },
                    child: CategoryChip(
                      label: controller.categories.sublist(3)[index],
                      isSelected:
                          controller.selectedSubCategoryIndex.value == index,
                    ),
                  ),
                ),
              );
            }),
          ));
  }

  /*Widget buildVegetableList() {
    return Obx(() => controller.isLoading.value
        ? buildShimmerVegetableList()
        : ListView(
              padding: EdgeInsets.only(top: 16.h),
              children: [
        ListView.builder(
          shrinkWrap: true,
            itemCount: controller.vegetables?.length,
            itemBuilder: (context, index) {
              return VegetableItem(
                imagePath: ImageResource.veg1,
                name: controller.vegetables?[index].name ?? "N/A",
                price:
                '${controller.vegetables?[index].discountedPrice} € / piece',
              );
            })

        */ /*  VegetableItem(
          imagePath: ImageResource.veg2,
          name: 'Purple Cauliflower',
          price: '1.85 € / kg',
        ),
        VegetableItem(
          imagePath: ImageResource.veg3,
          name: 'Savoy Cabbage',
          price: '1.45 € / kg',
        ),*/ /*
        // Add more VegetableItem widgets as needed
              ],
            ));
  }*/
  Widget buildVegetableList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return buildShimmerVegetableList(); // Show a loading indicator or shimmer effect
      } else {
        return ListView.builder(
          padding: EdgeInsets.only(top: 16.h),
          itemCount: controller.vegetables.length,
          itemBuilder: (context, index) {
            final vegetable = controller.vegetables[index];
            return GestureDetector(
              onTap: () {
                log("message---->${vegetable.name}");
                // Get.toNamed(Routes.vegetableDetailsScreen);
                Get.toNamed(
                  Routes.vegetableDetailsScreen,
                  arguments: {
                    'title': vegetable.name,
                    'price': vegetable.discountedPrice.toString(),
                    'imageUrl': ImageResource.veg1,
                    "id":vegetable.id,
                    "discountedPrice":vegetable.discountedPrice,
                    "moq":vegetable.moq,
                    // Replace with actual image URL
                  },
                );
              },
              child: VegetableItem(
                imagePath: ImageResource.veg1, // Use appropriate image resource
                name: vegetable.name,
                price: '${vegetable.discountedPrice} € / piece',
              ),
            );
          },
        );
      }
    });
  }

  Widget buildShimmerCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 80.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildShimmerVegetableList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16.h),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            height: 120.h,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  CategoryChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: Icon(Icons.check_outlined,
                    size: 16.w, color: Color(0xff6c0de4)),
              ),
            Text(label),
          ],
        ),
        backgroundColor: isSelected ? Color(0xffe2cbfc) : Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Color(0xff6c0de4) : Colors.grey,
        ),
      ),
    );
  }
}

class VegetableItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  VegetableItem({
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final parts = price.split(' ');
    final priceValue = parts[0];
    final priceUnit = parts.sublist(1).join(' ');

    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(),
            SizedBox(width: 16.0),
            buildTextSection(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        imagePath,
        width: 150.w,
        height: 100.h,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildTextSection() {
    final parts = price.split(' ');
    final priceValue = parts[0];
    final priceUnit = parts.sublist(1).join(' ');

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16.0.w,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: priceValue,
                  style: TextStyle(
                    fontSize: 20.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' $priceUnit',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          buildActionButtons(),
        ],
      ),
    );
  }

  Widget buildActionButtons() {
    return Row(
      children: [
        buildFavoriteButton(),
        SizedBox(width: 15.w),
        buildAddToCartButton(),
      ],
    );
  }

  Widget buildFavoriteButton() {
    return Container(
      width: 68.w,
      height: 38.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: IconButton(
        icon: Icon(Icons.favorite_border, color: Colors.grey),
        onPressed: () {},
      ),
    );
  }

  Widget buildAddToCartButton() {
    return Container(
      width: 68.w,
      height: 38.h,
      decoration: BoxDecoration(
        color: Colors.green.shade400,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: IconButton(
        icon: Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () {
          Get.toNamed(Routes.addVegetableScreen);
        },
      ),
    );
  }
}
