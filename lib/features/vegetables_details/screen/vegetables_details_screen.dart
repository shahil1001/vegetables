import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/features/edit_vagetable_details_screen.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_details/controller/vegetables_details_screen_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class VegetablesDetailsScreen extends GetView<VegetablesDetailsScreenController> {
  const VegetablesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                top: 40, // Position from the top of the screen
                left: 16, // Position from the left side of the screen
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Get.back();
                    //Go to new screen from here
                  },
                ),
              ),
              Positioned(
                top: 40, // Position from the top of the screen
                right: 16, // Position from the left side of the screen
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    Get.to(() => EditVegetableDetailsScreen(), arguments: {
                      'name': controller.title,
                      'moq': 20,
                      // Example value, replace it with actual data
                      'price': controller.price,
                      'discounted_price': 18,
                      // Example value, replace it with actual data
                      'id': 1,
                      // Example value, replace it with actual data
                    });
                   // Use GetX to navigate back
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

          // Rest of your UI
          Expanded(
            child: Container(
              decoration:  BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              transform: Matrix4.translationValues(0, -20, 0),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.title,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ).marginOnly(top: 20.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: controller.price,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' € / piece',
                          style: TextStyle(
                            fontSize: 20.w,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ).marginOnly(top: 20.h),
                  SizedBox(height: 10.h),
                  const Text(
                    '~ 150 gr / piece',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF00C853),
                        fontWeight: FontWeight.w600 // Green color
                    ),
                  ),
                  Text(
                    'Spain',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF3E206D), // Purple color
                    ),
                  ).marginOnly(top: 20.h),
                  Text(
                    'Lettuce is an annual plant of the daisy family, Asteraceae. '
                        'It is most often grown as a leaf vegetable, but sometimes for its stem and seeds. '
                        'Lettuce is most often used for salads, although it is also seen in other kinds of food, '
                        'such as soups, sandwiches and wraps; it can also be grilled.',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xFFB0A4C2),
                        fontWeight: FontWeight.w500 // Light purple color
                    ),
                  ).marginOnly(top: 20.h),

                  // Spacer
                  const Spacer(),

                  // Bottom buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: [
                        // OutlinedButton for the favorite icon
                        Container(
                          width: 68.w,
                          height: 54.h,
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
                        ),
                        const SizedBox(width: 16),
                        // ElevatedButton for "ADD TO CART"
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Handle add to cart action
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
                              Icons.shopping_cart,
                              size: 24, // Exact size as shown in the image
                            ),
                            label: const Text(
                              'ADD TO CART',
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
        ],
      ),
    );
  }
}
