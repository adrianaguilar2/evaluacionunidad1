// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      home: BlocProvider(
        create: (_) => TaskBloc(),
        child: const TaskPage(),
      ),
    );
  }
}

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(controller: controller),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      context.read<TaskBloc>().add(AddTask(controller.text));
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoaded) {
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(state.tasks[index]));
                    },
                  );
                }
                return const Center(child: Text('No tasks yet.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
