import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNoteForm extends StatefulWidget {
  final String? noteId;
  final String? initialTitle;
  final String? initialContent;

  AddNoteForm({this.noteId, this.initialTitle, this.initialContent});

  @override
  _AddNoteFormState createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool isProcessing = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submitNote() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isProcessing = true;
      });

      String title = _titleController.text.trim();
      String content = _contentController.text.trim();

      if (title.isNotEmpty && content.isNotEmpty) {
        try {
          if (widget.noteId == null) {
            // Adding a new note
            await FirebaseFirestore.instance.collection("notes").doc().set({
              "createDate": DateTime.now(),
              "title": title,
              "descr": content,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Note added successfully!')),
            );
          } else {
            await FirebaseFirestore.instance
                .collection("notes")
                .doc(widget.noteId)
                .update({
              "title": title,
              "descr": content,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Note updated successfully!')),
            );
          }

          _titleController.clear();
          _contentController.clear();
          Navigator.pop(context);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving note. Please try again.')),
          );
        } finally {
          setState(() {
            isProcessing = false;
          });
        }
      } else {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteId == null ? 'Add New Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              isProcessing
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitNote,
                      child: Text(
                          widget.noteId == null ? 'Add Note' : 'Update Note'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
