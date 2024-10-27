import 'dart:typed_data'; // Correct import for Uint8List
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/vendor_register_controller.dart';
import '../screen/landing_Screen_withmodel.dart';

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({super.key});

  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  VendorController _authController = VendorController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String countryValue;
  late String stateValue;
  late String cityValue;
  Uint8List? _image;
  late String bussinessName;
  late String email;
  late String phoneNumber;
  late String taxNumber;

  _saveVendorDeails() async {
    EasyLoading.show(status: 'PLEASE WAIT');

    if (_formKey.currentState!.validate()) {
      await _authController
          .registerVendor(
        bussinessName,
        email,
        phoneNumber,
        countryValue,
        stateValue,
        cityValue,
        _taxStatus!,
        taxNumber,
        _image,
      )
          .whenComplete(() {
        EasyLoading.dismiss();
      });
      // .whenComplete(EasyLoading.dismiss);
      setState(() {
        _formKey.currentState!.reset();
        _image = null;
      });
    } else {
      print('Form validation failed');
      EasyLoading.dismiss();
    }
  }

  selectGalleryImage() async {
    Uint8List im = await _authController.pickStoreImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  selectCamaraImage() async {
    Uint8List im = await _authController.pickStoreImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  String? _taxStatus;
  List<String> _taxOptions = ['YES', 'NO'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 220,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              // Changed Constraints to constraints (lowercase)
              return FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.yellow.shade900,
                        Colors.yellow,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    _image!,
                                    fit: BoxFit.cover,
                                    width: 90,
                                    height: 90,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    selectGalleryImage();
                                  },
                                  icon: Icon(CupertinoIcons.photo),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        bussinessName = value;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Business Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tax Registered?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Flexible(
                          child: Container(
                            width: 150,
                            child: DropdownButtonFormField<String>(
                              hint: Text('Select'),
                              items: _taxOptions
                                  .map((value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                                  .toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _taxStatus = newValue!;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    if (_taxStatus == 'YES')
                      TextFormField(
                        onChanged: (value) {
                          taxNumber = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Tax Number',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please fill the field';
                          } else {
                            return null;
                          }
                        },
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        _saveVendorDeails();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LandingScreen(),
                            ));
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade900,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
