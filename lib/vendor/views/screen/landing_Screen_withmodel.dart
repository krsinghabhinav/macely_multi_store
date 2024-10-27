import 'package:bestproviderproject/vendor/views/screen/main_vender_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/vendor_user_model.dart';
import '../auth/vendor_auth_screen.dart';
import '../auth/vendor_registration_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _vendorStream =
        FirebaseFirestore.instance.collection('vendors');

    // Check if the user is logged in
    if (_auth.currentUser == null) {
      return VendorAuthScreen();
    }

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _vendorStream.doc(_auth.currentUser!.uid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // Handle error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(fontSize: 30),
              ),
            );
          }

          // Show loading spinner while waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Check if snapshot has data and if the document exists
          if (!snapshot.data!.exists) {
            return VendorRegistrationScreen();
          }

          // Parse the document data into VendorUserModel
          var vendorUserModel = VendorUserModel.fromJson(
            snapshot.data!.data()! as Map<String, dynamic>,
          );

          if (vendorUserModel.approved == true) {
            return MainVenderScreen();
          }

          // Display vendor data in the UI
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: vendorUserModel.image != null
                        ? NetworkImage(vendorUserModel.image!)
                        : AssetImage('assets/images/default_avatar.png')
                            as ImageProvider, // Use a default image
                  ),
                  Text(
                    '${vendorUserModel.bussinessName ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your application has been sent to the shop admin',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Admin will get back to you soon',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VendorAuthScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign out',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
