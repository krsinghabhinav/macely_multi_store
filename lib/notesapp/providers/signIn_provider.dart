import 'package:bestproviderproject/notesapp/note_main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingInProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firebasefirestore = FirebaseFirestore.instance;

  String _email = '';
  String _password = '';
  bool _isLoading = false;

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;

  void setEmail(value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(value) {
    _password = value;
    notifyListeners();
  }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getLoginIn(BuildContext context) async {
    setIsLoading(true);
    notifyListeners();

    try {
      final firebaseUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (firebaseUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NoteMainScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Check email and password')),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SignIn successful!')),
      );
      setIsLoading(false);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SignIn failed: $e')),
      );
    }
    setIsLoading(false);
    notifyListeners();
  }
}
