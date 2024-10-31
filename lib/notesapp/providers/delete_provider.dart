import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteProvider with ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getDeleteNotes(BuildContext context, String noteId) async {
    setLoading(true);
    notifyListeners();

    try {
      await _firebaseFirestore.collection('addnotes').doc(noteId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note deleted successfully!')),
      );
      setLoading(false);
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete note: $e')),
      );
      setLoading(false);
      notifyListeners();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }
}
