import 'dart:typed_data';

import 'package:bestproviderproject/controllers/auth_controller.dart';
import 'package:bestproviderproject/utils/show_snackBar.dart';
import 'package:bestproviderproject/views/buyers/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String fullName;
  late String password;
  late String phoneNumber;
  Uint8List? _image;
  bool _isloading = false;

  _signUser() async {
    setState(() {
      _isloading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController
          .signUpUsers(email, fullName, phoneNumber, password, _image!)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isloading = false;
        });
      });
      // String res = await _authController.signUpUsers(
      //     email, fullName, phoneNumber, password);
      // if (res != 'success') {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text(res)));
      // } else {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text("Good")));
      // }
      return showSnack(context, "Account has been created",
          color: const Color.fromARGB(255, 14, 100, 17));
    } else {
      setState(() {
        _isloading = false;
      });
      return showSnack(context, "Please  fill all the fields",
          color: Colors.red);
    }
  }

  selectGalleryImage() async {
    Uint8List im =
        await _authController.pickerProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  selectCamaraImage() async {
    Uint8List im = await _authController.pickerProfileImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Create Customer\'s Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Stack(children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.yellow.shade900,
                          backgroundImage: MemoryImage(_image!),
                          // child: Icon(
                          //   Icons.person,
                          //   size: 100,
                          // ),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.yellow.shade900,
                          child: Icon(
                            Icons.person,
                            size: 90,
                          ),
                        ),
                  Positioned(
                    right: 0,
                    top: 70,
                    child: IconButton(
                      onPressed: () {
                        selectGalleryImage();
                      },
                      icon: Icon(
                        CupertinoIcons.photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    // right: 0,
                    top: 70,
                    left: 0,
                    right: 90,
                    child: IconButton(
                      onPressed: () {
                        selectCamaraImage();
                      },
                      icon: Icon(
                        CupertinoIcons.camera,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter full Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your full name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Phone Number',
                    ),
                    keyboardType:
                        TextInputType.phone, // Set the keyboard to numeric
                    maxLength: 10, // Limit the input to 10 digits
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (value.length != 10) {
                        return 'Phone number must be exactly 10 digits';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Phone number must contain only digits';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    // obscureText: true, // To hide the password input
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8) {
                        return 'Password should be at least 8 characters long';
                      } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                        return 'Password should contain at least one uppercase letter';
                      } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                        return 'Password should contain at least one lowercase letter';
                      } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                        return 'Password should contain at least one number';
                      } else if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
                        return 'Password should contain at least one special character (@, !, %, *, ?, &)';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _signUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isloading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : Text(
                              "Register",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(
                            LoginScreen(),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
