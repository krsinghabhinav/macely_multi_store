import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreatenoteProvider with ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String _createNotes = '';
  bool _isloading = false;

  String get createNotes => _createNotes;
  bool get isloading => _isloading;

  void setCreateNotes(String value) {
    _createNotes = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  Future<void> getCreateNotes(BuildContext context) async {
    // Check if createNotes is empty
    if (_createNotes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note cannot be empty!')),
      );
      return; // Exit the method if the note is empty
    }

    setIsLoading(true);
    notifyListeners();

    try {
      await _firebaseFirestore.collection("addnotes").doc().set({
        "createNote": createNotes,
        'createdAt': FieldValue
            .serverTimestamp(), // Use server timestamp for consistency
        'userId': user!.uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note added successfully!')),
      );
      setCreateNotes(''); // Clear the note after adding
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add note: $e')),
      );
    } finally {
      setIsLoading(false);
      notifyListeners(); // Notify listeners regardless of success or failure
    }
  }
}
