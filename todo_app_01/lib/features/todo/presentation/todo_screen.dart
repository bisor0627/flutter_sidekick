// features/todo/presentation/todo_screen.dart
// ------------------------------
// TodoScreen: 상태와 UI 연동 (ConsumerWidget)
// ------------------------------
//
// - Riverpod의 ConsumerWidget을 사용해 상태와 UI를 연결합니다.
// - TextField로 할 일 입력, ListView로 할 일 목록 표시
// - 각 Todo의 완료/미완료 토글, 삭제 기능 제공
//
// [CS 지식]
// - UI와 상태(State)의 분리는 SRP(단일 책임 원칙)를 지키는 핵심 설계입니다.
// - 상태 변화에 따라 UI가 자동으로 갱신되는 리액티브 패턴을 경험할 수 있습니다.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/todo_controller.dart';

class TodoScreen extends ConsumerWidget {
  TodoScreen({super.key});

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
                  child: TextField(),
                  // IconButton(
                  //   icon: const Icon(Icons.add),
                  //   onPressed: () {
                  //     controller.add(ref.watch(textControllerProvider).text);
                  //     ref.watch(textControllerProvider).clear();
                  //   },
                ),
              ],
            ),
          ),
          // if (state.isLoading) const CircularProgressIndicator(),
          // if (state.error != null)
          //   Text(
          //     'Error: ${state.error}',
          //     style: const TextStyle(color: Colors.red),
          //   ),
          Expanded(
            child: ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => controller.remove(todo.id),
                  ),
                  onTap: () => controller.toggle(todo.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
