// features/todo/controller/todo_controller.dart
// ------------------------------
// TodoController: 상태 관리 로직 (Notifier, Riverpod)
// ------------------------------
//
// - NotifierProvider를 통해 상태(State)와 비즈니스 로직을 분리합니다.
// - Controller는 Presentation(UI) 계층과 State(데이터) 계층을 연결하는 역할을 합니다.
// - add, toggle, remove 등 CRUD 메서드를 제공합니다.
// - 각 메서드는 불변성을 유지하며 상태를 갱신합니다.
//
// - Uuid 패키지를 사용해 고유 id를 생성합니다.
//
// [CS 지식]
// - 상태 관리 패턴(State Management)은 UI와 비즈니스 로직의 분리를 통해 유지보수성과 테스트 용이성을 높입니다.
// - 불변 데이터 구조는 참조 투명성과 예측 가능한 상태 변화를 보장합니다.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/todo.dart';
import '../state/todo_state.dart';
import 'package:uuid/uuid.dart';

final todoControllerProvider = NotifierProvider<TodoController, TodoState>(
  TodoController.new,
);

class TodoController extends Notifier<TodoState> {
  final _uuid = const Uuid();

  @override
  TodoState build() => const TodoState();

  // Todo 추가
  void add(String title) {
    final newTodo = Todo(id: _uuid.v4(), title: title);
    state = state.copyWith(todos: [...state.todos, newTodo]);
  }

  // Todo 완료/미완료 토글
  void toggle(String id) {
    final updated = state.todos.map((todo) {
      return todo.id == id ? todo.copyWith(isDone: !todo.isDone) : todo;
    }).toList();
    state = state.copyWith(todos: updated);
  }

  // Todo 삭제
  void remove(String id) {
    state = state.copyWith(
      todos: state.todos.where((todo) => todo.id != id).toList(),
    );
  }
}
