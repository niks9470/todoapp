
class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final int priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate.toIso8601String(),
    'priority': priority,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    dueDate: DateTime.parse(json['dueDate']),
    priority: json['priority'],
  );
}