import 'package:flutter/material.dart';
import 'package:new_app/db/DatabaseHelper.dart';
import 'package:new_app/model/Note.dart';

class DisplayNote extends StatelessWidget {
  const DisplayNote({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteModel note =
        ModalRoute.of(context).settings.arguments as NoteModel;

    return Scaffold(
        appBar: AppBar(
          title: Text('Your note!'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                DatabaseHelper.db.deleteNote(note.id);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
            )
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(note.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 16.0),
                Text(note.body, style: TextStyle(fontSize: 18.0))
              ],
            )));
  }
}
