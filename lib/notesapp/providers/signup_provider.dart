import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../signin_screen.dart';

class SignUpProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String _userName = '';
  String _phone = '';
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  String get username => _userName;
  String get phone => _phone;
  String get email => _email;
  String get password => _password;
  bool get isLoding => _isLoading;

  void setUserName(value) {
    _userName = value;
    notifyListeners();
  }

  void setPhone(value) {
    _phone = value;
    notifyListeners();
  }

  void setEmail(value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(value) {
    _password = value;
    notifyListeners();
  }

  void setIsLogin(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getSignUp(BuildContext context) async {
    if (email.isEmpty ||
        phone.isEmpty ||
        username.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firebaseFirestore
          .collection("userdata")
          .doc(userCredential.user!.uid)
          .set({
        'username': username,
        'phone': phone,
        'email': email,
        'password': password,
        'usreId': userCredential.user!.uid,
        'createAt': DateTime.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful!')),
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotesHomeScreen()));

      // Clear the fields after successful signup
      setUserName('');
      setPhone('');
      setEmail('');
      setPassword('');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $e')),
      );
    }
    _isLoading = false;
    notifyListeners();
  }
}
