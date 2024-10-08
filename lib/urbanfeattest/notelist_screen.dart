import 'package:bestproviderproject/urbanfeattest/AddEditNoteScreen.dart';
import 'package:bestproviderproject/urbanfeattest/detalsscree.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  String? selectedNoteId;
  String searchQuery = '';

  void deleteNote(String noteId) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await FirebaseFirestore.instance.collection('notes').doc(noteId).delete();
      Get.snackbar("Success", "Note deleted successfully.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Screen'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search notes...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('notes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No notes found'));
                  }

                  final notes = snapshot.data!.docs;

                  final filteredNotes = notes.where((note) {
                    String title = note['title'].toLowerCase();
                    String description = note['descr'].toLowerCase();
                    return title.contains(searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredNotes.length,
                    itemBuilder: (BuildContext context, int index) {
                      var noteData = filteredNotes[index];
                      String noteId = noteData.id;
                      String title = noteData['title'];
                      String description = noteData['descr'];

                      return Card(
                        child: ListTile(
                          title: Text(title),
                          subtitle: Text(description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(NoteDetailScreen(
                                        title: title,
                                        description: description,
                                      ));
                                    },
                                    child: Text(
                                      "Preview",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () =>
                                    deleteNote(noteId), // Call delete function
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              selectedNoteId = noteId;
                            });
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              if (selectedNoteId != null) {
                FirebaseFirestore.instance
                    .collection('notes')
                    .doc(selectedNoteId)
                    .get()
                    .then((doc) {
                  if (doc.exists) {
                    String title = doc['title'];
                    String description = doc['descr'];
                    Get.to(AddNoteForm(
                      noteId: selectedNoteId!,
                      initialTitle: title,
                      initialContent: description,
                    ));
                  }
                });
              } else {
                Get.snackbar("Error", "Please select a note to edit.",
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: Icon(Icons.edit),
            heroTag: null,
          ),
          SizedBox(height: 10),
          // Add button
          FloatingActionButton(
            onPressed: () {
              Get.to(AddNoteForm());
            },
            child: Icon(Icons.add),
            heroTag: null,
          ),
        ],
      ),
    );
  }
}
