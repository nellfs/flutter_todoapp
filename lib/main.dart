import 'package:flutter/material.dart';
import 'package:flutter_todoapp/repositories/task_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Lista de Tarefas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final list = TaskRepository.list;

  void _addNewItem() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Adicionar nova tarefa"),
              actions: <Widget>[
                TextButton(
                  child: const Text("Adicionar"),
                  onPressed: () {},
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _addNewItem(),
          label: const Text("Adicionar"),
          icon: const Icon(Icons.add)),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int task) {
          return ListTile(
            title: Text(list[task].title),
            trailing: Text(list[task].description),
          );
        },
        separatorBuilder: (_, ___) => const Divider(),
        itemCount: list.length,
      ),
    );
  }
}
