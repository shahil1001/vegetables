import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/features/vegetables_details/controller/home_screen_controller.dart';
import 'package:get/get.dart';

class VegetablesDetailsScreen extends GetView<VegetablesDetailsScreenController> {
  const VegetablesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          // Image section
          Image.asset(
            controller.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Title and Price section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E206D), // Purple color
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${controller.price} € / piece',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFFB0A4C2), // Light purple color
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '~ 150 gr / piece',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF00C853), // Green color
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Spain',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E206D), // Purple color
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Lettuce is an annual plant of the daisy family, Asteraceae. '
                      'It is most often grown as a leaf vegetable, but sometimes for its stem and seeds. '
                      'Lettuce is most often used for salads, although it is also seen in other kinds of food, '
                      'such as soups, sandwiches and wraps; it can also be grilled.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFB0A4C2), // Light purple color
                  ),
                ),
              ],
            ),
          ),

          // Spacer
          const Spacer(),

          // Bottom buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle favorite action
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child:  Icon(Icons.favorite_border),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add to cart action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00C853), // Green color
                    ),
                    child: const Text('ADD TO CART'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
