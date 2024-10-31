import 'package:bestproviderproject/notesapp/create_notes_screen.dart';
import 'package:bestproviderproject/notesapp/providers/delete_provider.dart';
import 'package:bestproviderproject/notesapp/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/createnote_provider.dart';

class NoteMainScreen extends StatefulWidget {
  const NoteMainScreen({super.key});

  @override
  State<NoteMainScreen> createState() => _NoteMainScreenState();
}

class _NoteMainScreenState extends State<NoteMainScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CreatenoteProvider createnoteProvider =
        Provider.of<CreatenoteProvider>(context);

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
                  builder: (context) => SignInScreen(),
                ),
              );
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
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              createnoteProvider
                  .setSearch(value); // Call the setSearch directly
            },
            decoration: InputDecoration(
              labelText: 'Search Notes',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
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
// Assuming you're using a StreamBuilder or FutureBuilder to display notes
              final notes = snapshot.data!.docs;

// Filter notes based on the search query
              final filteredNotes = notes.where((note) {
                final noteTitle = note['createNote'].toString().toLowerCase();
                return noteTitle.contains(createnoteProvider.searchQuery
                    .toLowerCase()); // Use the provider's searchQuery
              }).toList();
              return ListView.builder(
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  final note = filteredNotes[index];
                  final noteId = note.id; // Retrieve the note ID
                  final createdAt = note['createdAt'];
                  final noteContent = note['createNote'];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    elevation: 2,
                    child: ExpansionTile(
                      title: Text(noteContent
                          .split('\n')
                          .first), // Show only the first line for the title
                      subtitle: createdAt != null
                          ? Text(
                              'Created at: $createdAt') // Display formatted date
                          : const Text('No date available'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Implement navigation to edit screen
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _showDeleteConfirmationDialog(noteId);
                            },
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Show only the first two lines of noteContent
                              Text(
                                noteContent,
                                maxLines: 1,
                                overflow: TextOverflow
                                    .ellipsis, // Show ellipsis if text overflows
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                  height:
                                      8), // Add space before detailed content
                              Text(
                                'Detailed Note Content: $noteContent',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }

  void _showDeleteConfirmationDialog(String noteId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final deleteProvider =
            Provider.of<DeleteProvider>(context, listen: false);
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                deleteProvider.getDeleteNotes(context, noteId);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without deleting
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
