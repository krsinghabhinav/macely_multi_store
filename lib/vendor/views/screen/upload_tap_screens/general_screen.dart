import 'package:bestproviderproject/provider/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? selectedItem;
  final List<String> _categoryList = [];

  dynamic _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      print("categories product==============${querySnapshot.docs}");
      querySnapshot.docs.forEach((docs) {
        print(docs.data());
        setState(() {
          _categoryList.add(docs['categoryName']);
        });

        print("categories product==============${docs['categoryName']}");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  String formateDate(DateTime date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');
    final outPutData = outPutDateFormate.format(date);
    return outPutData;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);

    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: (value) {
                  _productProvider.getFormData(productName: value);
                },
                decoration: InputDecoration(
                  hintText: 'Enter Product Name',
                  labelText: 'Enter Product Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Product Name';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  double? changeDouble = double.parse(value);

                  _productProvider.getFormData(productPrice: changeDouble);
                },
                decoration: InputDecoration(
                  hintText: 'Enter Product Price',
                  labelText: 'Enter Product Price',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Product Price';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  _productProvider.getFormData(quantity: int.parse(value));
                },
                decoration: InputDecoration(
                  hintText: 'Enter Product Quantity',
                  labelText: 'Enter Product Quantity',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Product Quantity';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                value: selectedItem,
                items: _categoryList.map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedItem = newValue; // Update local selected item
                    _productProvider.getFormData(
                        category: selectedItem); // Update provider
                    print('Selected value: $newValue');
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Select Category',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  _productProvider.getFormData(description: value);
                },
                maxLength: 500,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter Product Description',
                  labelText: 'Product Description',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Product Description';
                  } else {
                    return null;
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000))
                          .then((value) {
                        if (value != null) {
                          // Ensure the date is formatted before passing it to the provider
                          String formattedDate = formateDate(value);
                          _productProvider.getFormData(
                              scheduleDate: formattedDate);
                        }
                      });
                    },
                    child: Text(
                      'Schedule',
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                  if (_productProvider.productData['scheduleDate'] != null)
                    Text(
                      _productProvider.productData['scheduleDate'],
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18),
                    )
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     print(_productProvider.productData['productName']);
              //     print(_productProvider.productData['productPrice']);
              //     print(_productProvider.productData['quantity']);
              //     print(_productProvider.productData['category']);
              //     print(_productProvider.productData['scheduleDate']);
              //     print(_productProvider.productData['description']);
              //     print(_productProvider.productData['description']);
              //   },
              //   style: ElevatedButton.styleFrom(
              //     elevation: 4,
              //     shape: ContinuousRectangleBorder(
              //         borderRadius: BorderRadius.circular(20)),
              //     backgroundColor: Colors.red,
              //     foregroundColor: Colors.white,
              //   ),
              //   child: Text(
              //     'Save',
              //     style: TextStyle(
              //         color: const Color.fromARGB(255, 255, 255, 255),
              //         fontSize: 18),
              //   ),
              // ),
            ],
          ),
        ),
      ]),
    );
  }
}
