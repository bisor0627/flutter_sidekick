// features/todo/model/todo.dart
// ------------------------------
// Todo 모델 정의 (freezed + json_serializable)
// ------------------------------
//
// - 불변(immutable) 데이터 모델을 위해 freezed를 사용합니다.
// - JSON 직렬화/역직렬화를 위해 json_serializable을 사용합니다.
// - CS 관점에서 데이터 모델은 도메인 계층의 핵심 역할을 하며,
//   불변성과 타입 안정성을 통해 버그를 줄이고 유지보수를 용이하게 합니다.
//
// - id: 각 Todo를 고유하게 식별하는 값 (UUID 등)
// - title: 할 일의 제목
// - isDone: 완료 여부 (기본값 false)

import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    @Default(false) bool isDone,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
