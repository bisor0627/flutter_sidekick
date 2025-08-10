import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_02/feature/todo/controller/todo_controller.dart';

class TodoScreen extends ConsumerWidget {
  TodoScreen({super.key});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(todoControllerProvider.notifier);
    final state = ref.watch(todoControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('TODO')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(hintText: '할 일을 입력하세요'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final text = textController.text.trim();
                    if (text.isNotEmpty) {
                      controller.add(text);
                      textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  leading: Icon(
                    todo.isDone
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: todo.isDone ? Colors.green : null,
                  ),
                  splashColor: Colors.grey.withValues(alpha: 0.1),
                  onTap: () {
                    controller.toggle(todo.id);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
