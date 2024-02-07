import 'dart:convert';

class Task {
  final String title, description;
  bool done;

  static String encode(List<Task> tasks) => json.encode(
        tasks.map<Map<String, dynamic>>((task) => Task.toMap(task)).toList(),
      );

  static List<Task> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<Task>((task) => Task.fromJson(task))
          .toList();

  static Map<String, dynamic> toMap(Task task) => {
        'title': task.title,
        'description': task.description,
        'done': task.done,
      };

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
      title: jsonData['title'],
      description: jsonData['description'],
      done: jsonData['done'],
    );
  }

  Task({required this.title, required this.description, required this.done});
}
