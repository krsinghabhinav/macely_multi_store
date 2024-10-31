import 'package:bestproviderproject/notesapp/providers/createnote_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({super.key});

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {
  @override
  Widget build(BuildContext context) {
    final CreatenoteProvider createnoteProvider =
        Provider.of<CreatenoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Notes'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: null,
              onChanged: (value) {
                createnoteProvider.setCreateNotes(value);
              },
              decoration: InputDecoration(
                labelText: 'Add Notes',
                // border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  createnoteProvider.getCreateNotes(context);
                },
                child: Text('Add Notes'))
          ],
        ),
      ),
    );
  }
}
