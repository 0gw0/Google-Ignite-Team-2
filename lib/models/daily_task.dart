import 'package:cloud_firestore/cloud_firestore.dart';

class DailyTask {
  final String date;
  final List<String> tasks;

  DailyTask({
    required this.date,
    required this.tasks,
  });

  // Define a factory constructor to create DailyTask objects from snapshots
  factory DailyTask.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final date = data['date'] as String;
    final tasks = List<String>.from(data['tasks']);

    return DailyTask(
      date: date,
      tasks: tasks,
    );
  }
}