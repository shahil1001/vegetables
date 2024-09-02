class VegetablesListResponseModel {
  final List<Vegetable> vegetables;

  VegetablesListResponseModel({required this.vegetables});

  factory VegetablesListResponseModel.fromJson(List<dynamic> json) {
    return VegetablesListResponseModel(
      vegetables: json.map((item) => Vegetable.fromJson(item)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return vegetables.map((item) => item.toJson()).toList();
  }
}

class Vegetable {
  final String id;
  final String name;
  final String moq;
  final String price;
  final String discountedPrice;

  Vegetable({
    required this.id,
    required this.name,
    required this.moq,
    required this.price,
    required this.discountedPrice,
  });

  factory Vegetable.fromJson(Map<String, dynamic> json) {
    return Vegetable(
      id: json['id'],
      name: json['name'],
      moq: json['moq'],
      price: _formatPrice(json['price']),
      discountedPrice: _formatPrice(json['discounted_price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'moq': moq,
      'price': price,
      'discounted_price': discountedPrice,
    };
  }

  // Helper function to format prices
  static String _formatPrice(String price) {
    final double parsedPrice = double.parse(price);
    if (parsedPrice % 1 == 0) {
      // No decimals needed if it's a whole number
      return parsedPrice.toStringAsFixed(0);
    } else {
      // Two decimals if not a whole number
      return parsedPrice.toStringAsFixed(2);
    }
  }
}
