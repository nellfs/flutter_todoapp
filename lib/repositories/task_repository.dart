import 'package:flutter_todoapp/models/task.dart';

class TaskRepository {
  static List<Task> list = [
    Task(title: "Limpar casa", description: "Limpar a casa toda"),
    Task(title: "Estudar Flutter", description: "Aprender o básico"),
    Task(title: "Comprar comida", description: "Comprar cenoura, carne"),
  ];
}
