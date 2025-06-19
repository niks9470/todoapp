import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final int priority;
  final bool completed; // NEW FIELD

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.completed = false, // default to false
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw Exception('Task document missing id field');
    }
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: (json['dueDate'] is Timestamp)
          ? (json['dueDate'] as Timestamp).toDate()
          : DateTime.parse(json['dueDate']),
      priority: json['priority'] as int,
      completed: json['completed'] as bool? ?? false, // handle missing field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'completed': completed,
    };
  }
}