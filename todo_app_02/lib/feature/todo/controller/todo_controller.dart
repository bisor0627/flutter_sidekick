import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_02/feature/todo/model/todo.dart';
import 'package:todo_app_02/feature/todo/state/todo_state.dart';
import 'package:uuid/uuid.dart';

final todoControllerProvider = NotifierProvider<TodoController, TodoState>(
  TodoController.new,
);

class TodoController extends Notifier<TodoState> {
  final _uuid = const Uuid();

  @override
  TodoState build() => const TodoState();

  void add(String title) {
    final newTodo = Todo(id: _uuid.v4(), title: title);
    state = state.copyWith(todos: [...state.todos, newTodo]);
  }
}
