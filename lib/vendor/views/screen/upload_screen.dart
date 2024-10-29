import 'package:bestproviderproject/vendor/views/screen/main_vender_screen.dart';
import 'package:bestproviderproject/vendor/views/screen/upload_tap_screens/general_screen.dart';
import 'package:bestproviderproject/vendor/views/screen/upload_tap_screens/images_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../provider/product_provider.dart';
import 'upload_tap_screens/attribute_screen.dart';
import 'upload_tap_screens/shipping_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isSave = false;

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    child: FittedBox(
                        child: Text('General', textAlign: TextAlign.center))),
                Tab(
                    child: FittedBox(
                        child: Text('Shipping', textAlign: TextAlign.center))),
                Tab(
                    child: FittedBox(
                        child: Text('Attribute', textAlign: TextAlign.center))),
                Tab(
                    child: FittedBox(
                        child: Text('Image', textAlign: TextAlign.center))),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GeneralScreen(),
              ShippingScreen(),
              AttributeScreen(),
              ImagesScreen()
            ],
          ),
          bottomSheet: ElevatedButton(
            onPressed: () async {
              setState(() {
                _isSave = true;
              });
              EasyLoading.show(status: 'Please Wait');
              if (_formKey.currentState!.validate()) {
                final productId = Uuid().v4();
                await _firestore.collection('products').doc(productId).set({
                  'productId': productId,
                  'productName': _productProvider.productData['productName'],
                  'productPrice': _productProvider.productData['productPrice'],
                  'quantity': _productProvider.productData['quantity'],
                  'category': _productProvider.productData['category'],
                  'scheduleDate': _productProvider.productData['scheduleDate'],
                  'description': _productProvider.productData['description'],
                  'imageUrlList': _productProvider.productData['imageUrlList'],
                  'chargeShipping':
                      _productProvider.productData['chargeShipping'],
                  'shipingCharge':
                      _productProvider.productData['shipingCharge'],
                  'brandName': _productProvider.productData['brandName'],
                  'sizeList': _productProvider.productData['sizeList'],
                }).whenComplete(() {});
                print(
                    "chargeshipping value ===========${_productProvider.productData['chargeShipping']}");
                EasyLoading.dismiss();
                _productProvider.clearData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainVenderScreen(),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 4,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: _isSave
                ? Text(
                    'Saved',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18),
                  )
                : Text(
                    'Save',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18),
                  ),
          ),
        ),
      ),
    );
  }
}
