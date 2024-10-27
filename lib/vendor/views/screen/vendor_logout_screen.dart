import 'package:bestproviderproject/vendor/views/auth/vendor_auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class VendorLogoutScreen extends StatefulWidget {
  const VendorLogoutScreen({super.key});

  @override
  State<VendorLogoutScreen> createState() => _VendorLogoutScreenState();
}

class _VendorLogoutScreenState extends State<VendorLogoutScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VendorAuthScreen(),
            ),
          );
        },
        child: Text('Signout'),
      ),
    );
  }
}
