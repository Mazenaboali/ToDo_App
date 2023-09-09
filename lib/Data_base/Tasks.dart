class Task {
  String id;
  String title;
  String Description;
  DateTime datetime;
  bool isDone;
  Task(
      { this.id='',
      required this.title,
      required this.Description,
      required this.datetime,
      this.isDone = false});
  Task.FromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            Description: data['description'],
            datetime: DateTime.fromMicrosecondsSinceEpoch(data['dateTime']),
            isDone: data['isDone']);

  Map<String, dynamic> ToFirestore() {
    return {
      'id': id,
      'title': title,
      'description': Description,
      'dateTime': datetime.microsecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
