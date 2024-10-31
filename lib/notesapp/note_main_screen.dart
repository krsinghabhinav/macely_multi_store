import 'package:bestproviderproject/notesapp/create_notes_screen.dart';
import 'package:bestproviderproject/notesapp/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class NoteMainScreen extends StatefulWidget {
  const NoteMainScreen({super.key});

  @override
  State<NoteMainScreen> createState() => _NoteMainScreenState();
}

class _NoteMainScreenState extends State<NoteMainScreen> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateNotesScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("addnotes")
            .where('userId', isEqualTo: userId?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No notes available.'));
          }

          // Build a list of notes
          final notes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final createdAt = note['createdAt'];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                elevation: 2,
                child: ListTile(
                  title: Text(note['createNote']),
                  subtitle: createdAt is Timestamp
                      ? Text('Created at: ${createdAt.toDate()}')
                      : const Text('No date available'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to edit note screen (implement this)
                          // Pass the note data to the edit screen
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(note.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(String noteId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Implement delete note function
                FirebaseFirestore.instance
                    .collection("addnotes")
                    .doc(noteId)
                    .delete()
                    .then((_) {
                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Note deleted successfully!')),
                  );
                });
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
