import 'package:flutter/material.dart';
import 'package:flutter_todoapp/models/task.dart';
import 'package:flutter_todoapp/repositories/task_repository.dart';
import 'package:flutter_todoapp/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      // ),
      home: const MyHomePage(title: 'Lista de Tarefas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  var _list = TaskRepository.list;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future _save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', Task.encode(_list));
  }

  Future _load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      setState(() {
        _list = Task.decode(data);
      });
    }
  }

  void _addItem() {
    setState(() {
      _list.add(Task(
          title: _titleController.text,
          description: _descriptionController.text,
          done: false));
      _titleController.clear();
      _descriptionController.clear();
    });
    Navigator.pop(context);
    _save();
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
                TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Descrição', border: OutlineInputBorder())),
                const SizedBox(height: 10),
                ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  //     backgroundColor: Theme.of(context).colorScheme.primary,
                  //     minimumSize: const Size(double.infinity, 50)),
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
        itemBuilder: (BuildContext context, int index) {
          final task = _list[index];
          return Dismissible(
            background: Container(color: Theme.of(context).colorScheme.primary),
            key: ValueKey<Task>(task),
            onDismissed: (DismissDirection direction) {
              setState(() {
                _list.removeAt(index);
                _save();
              });
            },
            child: CheckboxListTile(
                value: task.done,
                onChanged: (bool? value) {
                  setState(() {
                    task.done = value!;
                    _save();
                  });
                },
                title: Text(task.title),
                subtitle: Text(task.description)),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: _list.length,
      ),
    );
  }
}
