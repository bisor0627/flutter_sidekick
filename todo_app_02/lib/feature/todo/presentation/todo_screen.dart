import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_02/feature/todo/controller/todo_controller.dart';
import 'package:todo_app_02/feature/todo/model/todo.dart';
import 'package:todo_app_02/feature/todo/presentation/todo_editor_modal.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});
  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final _scroll = ScrollController();
  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoControllerProvider.select((s) => s.todos));
    final controller = ref.read(todoControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        actions: [
          IconButton(
            tooltip: '새 TODO',
            icon: const Icon(Icons.add),
            onPressed: () => _openEditor(create: true, controller: controller),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditor(create: true, controller: controller),
        child: const Icon(Icons.add),
      ),
      body: todos.isEmpty
          ? const _EmptyState()
          : ListView.builder(
              controller: _scroll,
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Dismissible(
                  key: ValueKey('todo-${todo.id}'),
                  background: _swipeBg(left: true),
                  secondaryBackground: _swipeBg(left: false),
                  onDismissed: (_) => controller.remove(todo.id),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: IconButton(
                        tooltip: todo.isDone ? '미완료로 전환' : '완료로 전환',
                        icon: Icon(
                          todo.isDone
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: todo.isDone ? Colors.green : null,
                        ),
                        onPressed: () => controller.toggle(todo.id),
                      ),
                      title: Text(todo.title),
                      trailing: IconButton(
                        tooltip: '수정',
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            _openEditor(edit: todo, controller: controller),
                      ),
                      onTap: () =>
                          _openEditor(edit: todo, controller: controller),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _swipeBg({required bool left}) => Container(
    alignment: left ? Alignment.centerLeft : Alignment.centerRight,
    padding: EdgeInsets.only(left: left ? 16 : 0, right: left ? 0 : 16),
    color: Colors.red,
    child: const Icon(Icons.delete, color: Colors.white),
  );

  Future<void> _openEditor({
    bool create = false,
    Todo? edit,
    required TodoController controller,
  }) async {
    final res = await showTodoEditorModal(context, initial: edit);
    if (res == null) return;
    if (res.id == null) {
      controller.create(title: res.title);
    } else {
      controller.update(id: res.id!, title: res.title);
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '할 일이 없습니다.\n오른쪽 아래 버튼으로 추가해 보세요.',
        textAlign: TextAlign.center,
      ),
    );
  }
}
