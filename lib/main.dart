import 'package:flutter/material.dart';
import 'package:flutter_todoapp/models/task.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
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
  final _titleController = TextEditingController();

  void _addItem() {
    setState(() {
      list.add(Task(
          title: _titleController.text, description: "Limpar a casa toda"));
      _titleController.clear();
    });
    Navigator.pop(context);
  }

  void _showModal() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Criar Tarefa",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context))
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                        hintText: 'Título', border: OutlineInputBorder())),
                const SizedBox(height: 10),
                const TextField(
                    decoration: InputDecoration(
                        hintText: 'Descrição', border: OutlineInputBorder())),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () => _addItem(),
                  child: const Text("Criar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showModal(),
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
