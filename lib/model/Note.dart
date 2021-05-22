class NoteModel {
  final int id;
  final String title;
  final String body;
  final DateTime creationDate;

  NoteModel({this.id, this.title, this.body, this.creationDate});

  Map<String, dynamic> toMap() {
    print("In toMAp");
    return ({
      "id": id,
      "title": title,
      "body": body,
      "creationDate": creationDate.toIso8601String()
    });
  }
}
