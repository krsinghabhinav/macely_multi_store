import 'package:bestproviderproject/vendor/views/screen/upload_tap_screens/general_screen.dart';
import 'package:bestproviderproject/vendor/views/screen/upload_tap_screens/images_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/product_provider.dart';
import 'upload_tap_screens/attribute_screen.dart';
import 'upload_tap_screens/shipping_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
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

        // bottomSheet: ElevatedButton(
        //   onPressed: () {
        //     print(_productProvider.productData['productName']);
        //     print(_productProvider.productData['productPrice']);
        //     print(_productProvider.productData['quantity']);
        //     print(_productProvider.productData['category']);
        //     print(_productProvider.productData['scheduleDate']);
        //     print(_productProvider.productData['description']);
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.red,
        //     foregroundColor: Colors.white,
        //   ),
        //   child: Text('Save'),
        // ),
      ),
    );
  }
}
