import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/Data_base/Tasks.dart';
import 'package:to_do/utils/date%20utils.dart';

class MyDatabase {
  static CollectionReference<Task> getTasksCollection() {
    var tasksCollections = FirebaseFirestore.instance
        .collection('tasks')
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.FromFirestore(snapshot.data()!),
            toFirestore: (task, options) => task.ToFirestore());
    return tasksCollections;
  }

  static Future<void> insertTask(Task task) {
    var tasksCollection = getTasksCollection();
    tasksCollection.doc();
    var doc = tasksCollection.doc();
    task.id = doc.id;
    task.datetime = MyDateUtils.ExtractDateonly(task.datetime);
    return doc.set(task);
  }

  static Future<List<Task>> getTasks(DateTime dateTime) async {
    var querySnapShot = await getTasksCollection()
        .where('dateTime',
            isEqualTo:
                MyDateUtils.ExtractDateonly(dateTime).microsecondsSinceEpoch)
        .get();
    var tasksList = querySnapShot.docs.map((doc) => doc.data()).toList();
    return tasksList;
  }

  static Future<void> delectTask(Task task) {
    var taskDoc = getTasksCollection().doc(task.id);
    return taskDoc.delete();
  }

  static Stream<QuerySnapshot<Task>> getTasksRealTimeUpdates(
      DateTime dateTime) {
    return getTasksCollection()
        .where('dateTime',
            isEqualTo:
                MyDateUtils.ExtractDateonly(dateTime).microsecondsSinceEpoch)
        .snapshots();
  }
}
