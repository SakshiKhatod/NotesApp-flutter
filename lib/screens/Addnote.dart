import 'package:flutter/material.dart';
import 'package:new_app/db/DatabaseHelper.dart';
import 'package:new_app/model/Note.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
  AddNote({Key key}) : super(key: key);
}

class _AddNoteState extends State<AddNote> {
  String title = "";
  String body = "";
  DateTime date;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  addNote(NoteModel note) {
    print("Note value");
    print(note.toString());
    print("Note value 1");
    print(note.toMap());
    print("Note value 2");
    print(note.title);
    print("Note value 3");
    print(note.body);
    print("Note value 4");
    print(note.creationDate);

    DatabaseHelper.db.addNewNote(note);
    print('Note added sucessfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add new note"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note Title",
                ),
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: TextField(
                  controller: bodyController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Your note",
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              title = titleController.text;
              body = bodyController.text;
              date = DateTime.now();
            });
            NoteModel note =
                NoteModel(title: title, body: body, creationDate: date);

            addNote(note);
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          },
          label: Text("Save note"),
          icon: Icon(Icons.save),
        ));
  }
}
