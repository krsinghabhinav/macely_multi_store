import 'package:bestproviderproject/notesapp/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForagetProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  String _email = '';
  bool _isloading = false;

  String get email => _email;
  bool get isloading => _isloading;

  void setEmail(email) async {
    _email = email;
    notifyListeners();
  }

  void setIsLoading(value) {
    _isloading = value;
    notifyListeners();
  }

  Future<void> getForgetPassword(BuildContext context) async {
    setIsLoading(true);
    notifyListeners();

    try {
      await _auth.sendPasswordResetEmail(email: _email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Forget Password successful!')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (contex) => NotesHomeScreen()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Forget Password failed: $e')),
      );
    }
    setIsLoading(false);
    notifyListeners();
  }
}
