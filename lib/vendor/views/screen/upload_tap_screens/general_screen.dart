import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
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
        _categoryList.add(docs['categoryName']);
        print("categories product==============${docs['categoryName']}");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  decoration: InputDecoration(
                hintText: 'Enter Product Name',
                labelText: 'Enter Product Name',
              )),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  decoration: InputDecoration(
                hintText: 'Enter Product Price',
                labelText: 'Enter Product Price',
              )),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  decoration: InputDecoration(
                hintText: 'Enter Product Quantity',
                labelText: 'Enter Product Quantity',
              )),
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
                    selectedItem = newValue;
                  });
                  print('Selected value: $newValue');
                },
                decoration: InputDecoration(
                  hintText: 'Select Category',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 500,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter Product Description',
                  labelText: 'Product Description',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000));
                      },
                      child: Text(
                        'Schedule',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      )),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
