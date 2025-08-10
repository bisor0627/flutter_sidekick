/// 할 일(TODO) 데이터 모델
/// The `Todo` class in Dart represents a task with an id, title, and completion status that can be
/// copied with optional new values.
class Todo {
  final String id;
  final String title;
  final bool isDone;
  const Todo({required this.id, required this.title, this.isDone = false});
  Todo copyWith({String? id, String? title, bool? isDone}) => Todo(
    id: id ?? this.id,
    title: title ?? this.title,
    isDone: isDone ?? this.isDone,
  );
}
