import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic> productData = {};
  getFormData({
    String? productName,
    double? productPrice,
    int? quantity,
    String? category,
    String? scheduleDate,
    String? description,
    List<String>? imageUrlList,
  }) {
    if (productName != null) {
      productData['productName'] = productName;
    }

    if (productPrice != null) {
      productData['productPrice'] = productPrice;
    }
    if (quantity != null) {
      productData['quantity'] = quantity;
    }
    if (category != null) {
      productData['category'] = category;
    }
    if (description != null) {
      productData['description'] = description;
    }

    if (scheduleDate != null) {
      productData['scheduleDate'] = scheduleDate; // Store the selected date
    }

    if (imageUrlList != null) {
      productData['imageUrlList'] = imageUrlList; // Store the selected date
    }
    notifyListeners();
  }
}
