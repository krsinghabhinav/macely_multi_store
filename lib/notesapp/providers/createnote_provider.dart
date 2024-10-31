import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

import '../note_main_screen.dart';

class CreatenoteProvider with ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String _createNotes = '';
  bool _isloading = false;
  String _searchQuery = '';

  String get createNotes => _createNotes;
  String get searchQuery => _searchQuery;
  bool get isloading => _isloading;
  void setCreateNotes(String value) {
    _createNotes = value;
    notifyListeners();
  }

  void setSearch(String value) {
    _searchQuery = value;
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
        const SnackBar(content: Text('Note cannot be empty!')),
      );
      return; // Exit the method if the note is empty
    }

    setIsLoading(true);
    notifyListeners();

    try {
      // Format the current date as dd/MM/yyyy
      String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      await _firebaseFirestore.collection("addnotes").doc().set({
        "createNote": _createNotes,
        'createdAt':
            formattedDate, // Save formatted date instead of server timestamp
        'userId': user!.uid,
      });

      // Only navigate and show success message if the note is successfully added
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note added successfully!')),
      );

      // Navigate after successful addition
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NoteMainScreen()),
      );

      setCreateNotes(''); // Clear the note after adding
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add note: $e')),
      );
      setIsLoading(false);
      notifyListeners();
    } finally {
      setIsLoading(false);
      notifyListeners();
    }
  }
}
