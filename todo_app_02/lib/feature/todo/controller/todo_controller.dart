import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_02/feature/todo/model/todo.dart';
import 'package:todo_app_02/feature/todo/state/todo_state.dart';
import 'package:uuid/uuid.dart';

final todoControllerProvider = NotifierProvider<TodoController, TodoState>(
  TodoController.new,
);

class TodoController extends Notifier<TodoState> {
  // 새 Todo 생성
  void create({required String title}) {
    add(title);
  }

  // Todo 수정
  void update({required String id, required String title}) {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(title: title);
      }
      return todo;
    }).toList();
    state = state.copyWith(todos: updatedTodos);
  }

  // Todo 삭제
  void remove(String id) {
    state = state.copyWith(
      todos: state.todos.where((todo) => todo.id != id).toList(),
    );
  }

  final _uuid = const Uuid();

  @override
  TodoState build() => const TodoState();

  void add(String title) {
    final newTodo = Todo(id: _uuid.v4(), title: title);
    state = state.copyWith(todos: [...state.todos, newTodo]);
  }

  void toggle(String id) {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isDone: !todo.isDone);
      }
      return todo;
    }).toList();
    state = state.copyWith(todos: updatedTodos);
  }
}
