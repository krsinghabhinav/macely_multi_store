import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic> productData = {};

  void getFormData({
    String? productName,
    double? productPrice,
    int? quantity,
    String? category,
    String? scheduleDate,
    String? description,
    List<String>? imageUrlList,
    bool? chargeShipping,
    int? shipingCharge,
    String? brandName,
    List<String>? sizeList,
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
      productData['imageUrlList'] = imageUrlList; // Store the image URLs
    }
    if (chargeShipping != null) {
      productData['chargeShipping'] =
          chargeShipping; // Store the charge shipping
    }
    if (shipingCharge != null) {
      productData['shipingCharge'] = shipingCharge; // Store the shipping charge
    }
    if (brandName != null) {
      productData['brandName'] = brandName; // Store the brand name
    }
    if (sizeList != null) {
      productData['sizeList'] = sizeList; // Store the size list
    }
    notifyListeners();
  }
  clearData(){
    productData.clear();
    notifyListeners();
  }
}
