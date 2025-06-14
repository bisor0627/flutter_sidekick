// features/todo/state/todo_state.dart
// ------------------------------
// TodoState 정의 (freezed)
// ------------------------------
//
// - 앱의 상태를 표현하는 State 클래스입니다.
// - todos: Todo 목록 (불변 리스트)
// - isLoading: 비동기 작업 등에서 로딩 상태 표시
// - error: 에러 메시지 (nullable)
//
// - 상태(State)는 Presentation 계층과 Controller 계층 사이의 데이터 흐름을 담당합니다.
//   불변성을 유지함으로써, 상태 변경 시 UI가 안전하게 갱신될 수 있습니다.

import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/todo.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState({
    @Default([]) List<Todo> todos,
    @Default(false) bool isLoading,
    String? error,
  }) = _TodoState;
}
