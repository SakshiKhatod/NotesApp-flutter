import 'package:flutter/material.dart';
import 'package:new_app/screens/Addnote.dart';
import 'package:new_app/screens/Displaynote.dart';
import 'db/DatabaseHelper.dart';
import 'model/Note.dart';

void main() {
  Text('1');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/AddNote": (context) => AddNote(),
        "/DisplayNote": (context) => DisplayNote(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getNotes() async {
    final notes = await DatabaseHelper.db.getNotes();
    return notes;
    // print(1);
    // print(notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Notes',
        ),
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, noteData) {
          switch (noteData.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator());
              }
            case ConnectionState.done:
              {
                if (noteData.data == Null) {
                  return Center(
                    child: Text("You don't have any notes yet, create one!"),
                  );
                } else {
                  // return Center(
                  //   child: Text((noteData.data).toString()),
                  // );
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    // child: Text('Hello'),
                    child: ListView.builder(
                      itemCount: noteData.data.length,
                      itemBuilder: (context, index) {
                        String title = noteData.data[index]['title'];
                        String body = noteData.data[index]['body'];
                        String creationDate =
                            noteData.data[index]['creationDate'];
                        int id = noteData.data[index]['id'];

                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "/DisplayNote",
                                  arguments: NoteModel(
                                    id: id,
                                    title: title,
                                    body: body,
                                    creationDate: DateTime.parse(creationDate),
                                  ));
                            },
                            title: Text(title),
                            subtitle: Text(body),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
          }
          return Center(
            child: Text("You don't have any notes yet, create one!"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/AddNote");
        },
        child: Icon(Icons.note_add),
      ),
    );
  }
}
